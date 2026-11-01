{ self, ... }:
{
  den.aspects.nixpkgs.nixos = { host, ... }: {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ self.overlays.${host.theme.name} ];
  };
}
