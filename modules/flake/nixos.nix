{
  inputs,
  config,
  lib,
  withSystem,
  ...
}: {
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.submodule {
      options = with lib; {
        system = mkOption {type = types.str;};
        version = mkOption {type = types.str;};

        module = mkOption {
          type = types.deferredModule;
          default = {};
        };
      };
    });
  };

  config.flake = {
    nixosConfigurations = lib.flip lib.mapAttrs config.configurations.nixos (
      name: value:
        inputs.nixpkgs.lib.nixosSystem {
          pkgs = import inputs.nixpkgs {
            inherit (value) system;
            config.allowUnfree = true;
          };

          specialArgs = {
            self' =
              withSystem value.system
              ({self', ...}: self');

            inputs' =
              withSystem value.system
              ({inputs', ...}: inputs');
          };

          modules = [
            value.module

            {
              networking.hostName = name;
              system.stateVersion = value.version;
            }
          ];
        }
    );
  };
}
