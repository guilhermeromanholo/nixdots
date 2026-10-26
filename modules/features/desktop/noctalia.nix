{ self, ... }: {
  flake.wrappers.noctalia =
    {
      config,
      wlib,
      pkgs,
      lib,
      ...
    }:
    let
      toml = pkgs.formats.toml { };
      cfg = config;
    in
    {
      imports = [
        wlib.modules.default
        self.modules.generic.wrapper-theme
      ];
      options.settings = lib.mkOption {
        inherit (toml) type;
        default = { };
        description = "Configuração TOML do Noctalia v5. Estado mutável fica fora do store.";
      };
      config = {
        package = pkgs.noctalia;
        env.NOCTALIA_CONFIG_HOME = "${placeholder "out"}/config";
        # Noctalia reads settings.toml after the immutable config. Its atomic
        # writer follows symlinks, so pin this one file to the store while leaving
        # UI state, clipboard and other runtime files writable in a private root.
        runShell = [
          ''
            stateRoot="''${XDG_STATE_HOME:-$HOME/.local/state}/nixdots"
            settings="$stateRoot/noctalia/settings.toml"
            mkdir -p "$stateRoot/noctalia"
            if [ -e "$settings" ] || [ -L "$settings" ]; then
              if [ ! -L "$settings" ]; then
                echo "Noctalia: $settings já existe e não é um link gerenciado; preserve-o e revise-o antes de iniciar." >&2
                exit 1
              fi
              case "$(readlink "$settings")" in
                /nix/store/*/config/noctalia/config.toml) ;;
                *) echo "Noctalia: link de preferências desconhecido em $settings; revise-o antes de iniciar." >&2; exit 1 ;;
              esac
            fi
            if [ "$(readlink "$settings" 2>/dev/null || true)" != "${placeholder "out"}/config/noctalia/config.toml" ]; then
              ln -sfn "${placeholder "out"}/config/noctalia/config.toml" "$settings"
            fi
            export NOCTALIA_STATE_HOME="$stateRoot"
          ''
        ];
        runtimePkgs = [ pkgs.coreutils ];
        settings = {
          shell = {
            font_family = cfg.theme.fonts.sans;
            setup_wizard_enabled = false;
            polkit_agent = true;
          };
          theme = {
            mode = "dark";
            shell_mode = "dark";
            source = "custom";
            custom_palette = "nixdots";
          };
          idle.behavior = {
            lock = {
              enabled = true;
              action = "lock";
              timeout = 600;
            };
            screen-off = {
              enabled = true;
              action = "screen_off";
              timeout = 660;
            };
          };
          # Wallpaper is provided by swaybg; do not run two wallpaper owners.
          wallpaper.enabled = false;
        };
        constructFiles = {
          settings = {
            relPath = "config/noctalia/config.toml";
            content = builtins.toJSON cfg.settings;
            builder = "${pkgs.remarshal}/bin/json2toml \"$1\" \"$2\"";
          };
          palette = {
            relPath = "config/noctalia/palettes/nixdots.json";
            content = builtins.toJSON (import ./_noctalia-palette.nix { inherit (cfg) theme; });
          };
        };
        filesToPatch = [ "share/applications/noctalia.desktop" ];
      };
    };
  flake.modules.nixos.noctalia =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      assertions = [
        {
          assertion = lib.versions.major pkgs.noctalia.version == "5";
          message = "Esta configuração requer Noctalia v5 (pkgs.noctalia).";
        }
      ];
      users.users.${config.nixdots.user.name}.packages = [ pkgs.nixdots.noctalia ];
      security.pam.services.noctalia = { };
      services.upower.enable = true;
      services.power-profiles-daemon.enable = true;
      environment.persistence = lib.mkIf config.nixdots.persistence.enable {
        ${config.nixdots.persistence.root}.users.${config.nixdots.user.name}.directories = [
          ".local/state/nixdots/noctalia"
          ".local/share/noctalia"
          ".local/share/keyrings"
        ];
      };
    };
}
