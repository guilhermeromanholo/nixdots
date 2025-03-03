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
      _: dir:
        builtins.listToAttrs (map (module: {
          name = module;
          value = import (dir + "/${module}");
        }) (builtins.attrNames (builtins.readDir dir)))
    )
    config.parts.modules;
}
