{
  inputs,
  withSystem,
  ...
}: {
  flake.lib.mkNixos = {
    name,
    system,
  }: {
    ${name} = inputs.nixpkgs.lib.nixosSystem {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      specialArgs = {
        self' =
          withSystem system
          ({self', ...}: self');

        inputs' =
          withSystem system
          ({inputs', ...}: inputs');
      };

      modules = [
        {networking.hostName = name;}
        inputs.self.nixosModules.${name}
      ];
    };
  };
}
