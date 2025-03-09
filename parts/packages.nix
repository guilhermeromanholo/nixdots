{
  self,
  lib,
  config,
  ...
}: {
  options.parts.packages = lib.mkOption {
    type = lib.types.attrs;
    default = {};
    description = "Custom packages";
  };

  config.perSystem = {
    inputs',
    pkgs,
    ...
  }: {
    packages =
      {
        nixvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
          inherit pkgs;
          module = self.nixvimModules.default;
        };
      }
      // lib.mapAttrs (
        _: value: pkgs.callPackage value {}
      )
      config.parts.packages;
  };
}
