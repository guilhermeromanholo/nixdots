{
  inputs,
  lib,
  config,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = lib.flip lib.mapAttrs config.configurations.nixos (
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
            system.stateVersion = value.version;
          }
        ];
      }
  );
}
