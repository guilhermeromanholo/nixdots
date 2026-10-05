{
  inputs,
  lib,
  config,
  withSystem,
  ...
}: {
  options.configurations.nixos = with lib;
    mkOption {
      type = types.lazyAttrsOf (types.submodule {
        options = {
          system = mkOption {type = types.str;};
          version = mkOption {type = types.str;};
          username = mkOption {type = types.str;};
          module = mkOption {type = types.deferredModule;};
        };
      });
    };

  config.flake.nixosConfigurations = lib.flip lib.mapAttrs config.configurations.nixos (
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
          ./_custom.nix
          {
            networking.hostName = name;
            custom.username = value.username;
            system.stateVersion = value.version;
          }
        ];
      }
  );
}
