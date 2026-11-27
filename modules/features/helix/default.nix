{
  flake.nixosModules.helix = { pkgs, ... }: {
    key = "nixdots:modules/apps/helix/default.nix:helix";
    environment.systemPackages = [ pkgs.my.helix ];
  };
}
