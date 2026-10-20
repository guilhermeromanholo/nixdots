{
  lib,
  moduleWithSystem,
  ...
}: {
  flake.lib.mkModule = module:
    moduleWithSystem {
      imports = [module];

      options.my = lib.mkOption {
        type = lib.types.submodule {
          freeformType = lib.types.unspecified;
        };
      };
    };
}
