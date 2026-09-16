{
  lib,
  den,
  ...
}: {
  den.schema.host.imports = [
    ({...}: {
      options.disko = lib.mkOption {
        default = null;
        types = lib.types.submodule {
          options = {
            size = lib.mkOption {type = lib.types.str;};
            swap = lib.mkOption {type = lib.types.str;};
            device = lib.mkOption {type = lib.types.str;};
          };
        };
      };
    })
  ];

  den.schema.host.includes = [
    (den.lib.policy.when ({host, ...}: host.disko != null) (
      den.lib.policy.include den.aspects.disko
    ))
  ];
}
