{
  lib,
  config,
  ...
}: {
  options.parts.modules = lib.mkOption {
    type = lib.types.attrs;
  };

  config.flake = config.parts.modules;
}
