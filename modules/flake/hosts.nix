{
  inputs,
  lib,
  config,
  ...
}: {
  options.hosts.nixos = with lib;
    mkOption {
      type = types.lazyAttrsOf (types.submodule {
        options = {
          arch = mkOption {type = types.str;};
          version = mkOption {type = types.str;};

          username = mkOption {
            type = types.str;
            default = "guilherme";
          };

          module = mkOption {
            type = types.deferredModule;
            default = {};
          };
        };
      });
    };

  config.flake.nixosConfigurations = lib.flip lib.mapAttrs config.hosts.nixos (
    name: host:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {host = host // name;};
        modules = [inputs.self.modules.${name}];
      }
  );
}
