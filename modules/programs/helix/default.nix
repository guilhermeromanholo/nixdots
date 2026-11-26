{
  flake.nixosModules.helix = { pkgs, ... }: {
    key = "nixdots:modules/programs/helix/default.nix:helix";
    environment.systemPackages = [ pkgs.my.helix ];
  };
}
