{ self, ... }:
{
  flake.nixosModules.core = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ self.lib.mkOverlays ];
  };
}
