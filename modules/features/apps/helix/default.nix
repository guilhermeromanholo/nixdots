{
  flake.nixosModules.helix = {pkgs, ...}: {
    environment.systemPackages = [ pkgs.my.helix ];
  };
}
