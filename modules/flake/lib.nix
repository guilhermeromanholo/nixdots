{
  inputs,
  withSystem,
  ...
}: {
  flake.lib = {
    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;

    mkNixos = {
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

    applyTheme = path: pkgs: let
      base16Lib = pkgs.callPackage inputs.base16.lib {};
      scheme = base16Lib.mkSchemeAttrs inputs.self.theme;
    in
      scheme {template = builtins.readFile path;};
  };
}
