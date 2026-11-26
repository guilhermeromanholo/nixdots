{ lib, ... }:
{
  options.flake.lib = lib.mkOption {
    type = lib.types.submodule {
      freeformType = lib.types.attrsOf lib.types.unspecified;

      options.wrapperModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.deferredModule;
        default = { };
        description = "Shared modules imported by application wrappers.";
      };
    };
    default = { };
  };
}
