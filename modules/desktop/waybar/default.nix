{ lib, ... }:
{
  flake.nixosModules.waybar = { pkgs, ... }: {
    key = "nixdots:modules/desktop/waybar/default.nix:waybar";
    environment.systemPackages = [ pkgs.my.waybar ];
    session.autostart = [ [ (lib.getExe pkgs.my.waybar) ] ];
  };
}
