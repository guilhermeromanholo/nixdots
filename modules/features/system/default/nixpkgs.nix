{ self, ... }:
{
  flake.nixosModules.default = {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ self.overlays.default ];
  };
}
