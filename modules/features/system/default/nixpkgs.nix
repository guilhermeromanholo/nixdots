{ self, ... }:
{
  flake.nixosModules.default = { config, ... }: {
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ self.overlays.${config.settings.theme.name} ];
  };
}
