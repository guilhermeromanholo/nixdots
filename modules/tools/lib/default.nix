{
  inputs,
  self,
  lib,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {
    mkNixos = name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [self.modules.nixos.${name}];
      };
    };

    mkHomeManager = name: system: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [self.modules.homeManager.${name}];
      };
    };
  };
}
