{
  flake.modules.nixos.nixpkgs = {
    nixpkgs.overlays = [ ];
    nixpkgs.config.allowUnfree = true;
  };
}
