{
  inputs,
  self,
  ...
}: {
  config.flake.lib = {
    mkHomeManager = name: system: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        modules = [self.modules.homeManager.${name}];
      };
    };
  };
}
