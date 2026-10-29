{
  den.aspects.system.nixpkgs = {
    nixos = {
      nixpkgs.overlays = [ ];
      nixpkgs.config.allowUnfree = true;
    };
  };
}
