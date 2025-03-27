{
  self,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) types;
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  options.parts.nixosConfigurations = lib.mkOption {
    type = types.attrsOf (types.submodule {
      options = {
        system = lib.mkOption {
          type = types.str;
          description = "System architecture";
        };

        stateVersion = lib.mkOption {
          type = types.str;
          description = "NixOS state version";
        };

        modules = lib.mkOption {
          type = types.listOf types.unspecified;
          default = [];
          description = "List of NixOS modules";
        };
      };
    });
  };

  config.flake.nixosConfigurations =
    builtins.mapAttrs
    (name: value:
      nixosSystem {
        inherit (value) system;

        pkgs = import inputs.nixpkgs {
          system = value.system;
          config.allowUnfree = true;
          overlays = lib.attrValues self.overlays;
        };

        specialArgs = {
          inherit inputs;
          inherit (self) outputs;
        };

        modules =
          value.modules
          ++ lib.attrValues self.nixosModules
          ++ [
            {
              networking.hostName = name;
              system.stateVersion = value.stateVersion;
            }
          ];
      })
    config.parts.nixosConfigurations;
}
