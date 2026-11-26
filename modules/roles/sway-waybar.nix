{ self, lib, ... }:
{
  flake.nixosModules.sway-waybar = { config, pkgs, ... }: {
    key = "nixdots:modules/roles/sway-waybar.nix:sway-waybar";
    imports = with self.nixosModules; [
      sway
      waybar
      kitty
    ];
    session.actions = {
      "terminal.open" = config.session.actions."kitty.open";
      "launcher.open".argv = [ (lib.getExe pkgs.fuzzel) ];
      "session.lock".argv = [ (lib.getExe pkgs.swaylock) ];
      "screenshot.region".argv = [
        (lib.getExe (
          pkgs.writeShellScriptBin "screenshot-region" ''
            set -euo pipefail
            geometry="$(${lib.getExe pkgs.slurp})"
            ${lib.getExe pkgs.grim} -g "$geometry" - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"} --type image/png
          ''
        ))
      ];
    };
  };
}
