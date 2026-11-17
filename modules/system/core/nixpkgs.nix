{
  flake.nixosModules.nixpkgs = {
    nixpkgs.overlays = [ ];
    nixpkgs.config.allowUnfree = true;
  };
}
