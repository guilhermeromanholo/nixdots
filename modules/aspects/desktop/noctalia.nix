{ config, lib, ... }:
let
  theme-default = config.themes.gruvbox;
in
{
  den.aspects.noctalia.nixos = { pkgs, ... }: {
    security.pam.services.noctalia = { };

    programs.noctalia.enable = true;
    programs.noctalia.package = pkgs.my.noctalia;
  };

  flake.wrappers.noctalia =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [ wlib.modules.default ];

      options = {
        theme = lib.mkOption {
          default = theme-default;
          type = lib.types.attrs;
        };

        settings = lib.mkOption {
          default = { };
          inherit (pkgs.formats.toml { }) type;
        };
      };

      config = {
        package = pkgs.noctalia;
        env.NOCTALIA_CONFIG_HOME = "${placeholder "out"}/config";

        settings = {
          shell = {
            font_family = "Open Sans";
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
        };
        constructFiles = {
          settings = {
            relPath = "config/noctalia/config.toml";
            content = builtins.toJSON config.settings;
            builder = "${pkgs.remarshal}/bin/json2toml \"$1\" \"$2\"";
          };
          palette = {
            relPath = "config/noctalia/palettes/nixdots.json";
            content = builtins.toJSON (import ./_noctalia-palette.nix { inherit (config) theme; });
          };
        };
      };
    };
}
