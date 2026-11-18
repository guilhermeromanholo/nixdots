{ self, ... }:
{
  flake.nixosModules.nixpkgs = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ self.lib.mkOverlays ];
  };
}
