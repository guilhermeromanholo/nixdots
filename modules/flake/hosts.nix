{
  inputs,
  lib,
  config,
  ...
}: {
  config.flake.nixosConfigurations = lib.flip lib.mapAttrs config.hosts.nixos (
    name: host:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [inputs.self.modules.nixos.${name}];
        specialArgs = {host = host // {inherit name;};};
      }
  );

  options.hosts.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.submodule {
      options = {
        system = lib.mkOption {
          type = lib.types.str;
        };

        version = lib.mkOption {
          type = lib.types.str;
        };

        disk = {
          size = lib.mkOption {
            type = lib.types.str;
            default = "";
          };

          swap = lib.mkOption {
            type = lib.types.str;
            default = "";
          };

          device = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
        };

        username = lib.mkOption {
          type = lib.types.str;
          default = "guilherme";
        };
      };
    });
  };
}
