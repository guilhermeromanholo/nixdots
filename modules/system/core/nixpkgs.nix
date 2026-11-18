{ self, ... }:
{
  flake.nixosModules.nixpkgs = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ self.overlays.default ];
  };
}
