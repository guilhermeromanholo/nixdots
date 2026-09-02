{
  inputs,
  lib,
  config,
  ...
}: {
  options.configurations.nixos = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        arch = lib.mkOption {type = lib.types.str;};
        version = lib.mkOption {type = lib.types.str;};
      };
    });
  };

  config.flake.nixosConfigurations =
    lib.mapAttrs (
      name: value:
        inputs.nixpkgs.lib.nixosSystem {
          system = value.arch;

          modules = [
            inputs.self.modules.nixos.${name}
            {
              networking.hostName = name;
              system.stateVersion = value.version;
            }
          ];
        }
    )
    config.configurations.nixos;
}
