{
  self,
  inputs,
  lib,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    let
      hosts = self.nixosConfigurations // {
        tesla = inputs.nixpkgs.lib.nixosSystem { modules = [ self.modules.nixos.tesla ]; };
      };
      expected = {
        sunset = "gruvbox";
        taz = "nord";
        vortex = "nord";
        tesla = "gruvbox";
      };
      nord = import inputs.nixpkgs {
        system = pkgs.stdenv.hostPlatform.system;
        overlays = [ self.overlays.nord ];
      };
      hostSettings = lib.all (
        name:
        let
          c = hosts.${name}.config;
        in
        c.nixdots.theme.name == expected.${name}
        && c.nixdots.user.name == "guilherme"
        && !(hosts.${name}.options ? home-manager)
      ) (builtins.attrNames expected);
    in
    {
      checks = {
        # The upstream wrapper runs Mango's native parser during installation.
        mango-config = pkgs.nixdots.mango;
        host-settings =
          assert hostSettings;
          assert hosts.vortex.config.wsl.defaultUser == "guilherme";
          assert hosts.sunset.config.system.stateVersion == "24.11";
          assert hosts.taz.config.system.stateVersion == "24.11";
          assert hosts.vortex.config.system.stateVersion == "24.11";
          assert !(hosts.vortex.config.programs ? mango && hosts.vortex.config.programs.mango.enable);
          assert hosts.taz.config.environment.persistence == { };
          assert hosts.vortex.config.environment.persistence == { };
          pkgs.runCommand "host-settings" { } "touch $out";

        shell-editor =
          pkgs.runCommand "shell-editor-smoke"
            {
              nativeBuildInputs = [
                pkgs.nixdots.fish
                pkgs.nixdots.helix
                pkgs.nixdots.starship
                pkgs.python3
              ];
            }
            ''
              export HOME="$TMPDIR/home"
              mkdir -p "$HOME"
              export TERM=dumb
              fish --login -c 'test "$EDITOR" = "${lib.getExe pkgs.nixdots.helix}"'
              fish --interactive -c 'functions -q fish_prompt; and functions -q __direnv_export_eval'
              TERM=xterm-256color fish --interactive -c 'functions -q fish_prompt; and set -q STARSHIP_SHELL'
              hx --health nix > nix-health.txt
              hx --health python > python-health.txt
              grep -F '${lib.getExe pkgs.nixd}' nix-health.txt
              grep -F '${lib.getExe pkgs.ty}' python-health.txt
              python ${../../tests/lsp-smoke.py} ${lib.getExe pkgs.nixd}
              python ${../../tests/lsp-smoke.py} ${lib.getExe pkgs.ty} server
              touch "$out"
            '';

        noctalia-config =
          pkgs.runCommand "noctalia-config"
            {
              nativeBuildInputs = [ pkgs.nixdots.noctalia ];
            }
            ''
              export HOME="$TMPDIR/home"
              mkdir -p "$HOME"
              noctalia config validate ${pkgs.nixdots.noctalia}/config/noctalia/config.toml > validation.log 2>&1
              cat validation.log
              if grep -E 'WARN|ERROR' validation.log; then exit 1; fi
              test "$(readlink "$HOME/.local/state/nixdots/noctalia/settings.toml")" = \
                "${pkgs.nixdots.noctalia}/config/noctalia/config.toml"
              noctalia config export > effective.toml
              touch "$out"
            '';

        theme-variants = pkgs.runCommand "theme-variants" { } ''
          grep -F '#282828' ${pkgs.nixdots.kitty}/kitty.conf
          grep -F '#2E3440' ${nord.nixdots.kitty}/kitty.conf
          grep -F '#83a598' ${pkgs.nixdots.starship}/starship.toml
          grep -F '#81A1C1' ${nord.nixdots.starship}/starship.toml
          grep -F '#282828' ${pkgs.nixdots.helix.generatedConfig}/themes/nixdots.toml
          grep -F '#2E3440' ${nord.nixdots.helix.generatedConfig}/themes/nixdots.toml
          touch "$out"
        '';
      };
    };
}
