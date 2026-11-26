{ lib, ... }:
{
  flake.nixosModules.kitty = { pkgs, ... }: {
    key = "nixdots:modules/programs/kitty/default.nix:kitty";
    environment.systemPackages = [ pkgs.my.kitty ];
    session.actions."kitty.open".argv = [ (lib.getExe pkgs.my.kitty) ];
  };
}
