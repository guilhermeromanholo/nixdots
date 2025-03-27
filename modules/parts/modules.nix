{
  lib,
  config,
  ...
}: {
  options.parts.modules = lib.mkOption {
    type = lib.types.attrs;
  };

  config.flake =
    lib.mapAttrs (
      _: module:
        lib.mapAttrs (
          _: subModule: import subModule
        )
        module
    )
    config.parts.modules;
}
