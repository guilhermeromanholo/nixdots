{
  inputs,
  withSystem,
  ...
}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  flake.lib = {
    mkIfPersistence = config: settings:
      if config.environment ? persistence
      then {persistence."/persist" = settings;}
      else {};

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
          self' = withSystem system ({self', ...}: self');
          inputs' = withSystem system ({inputs', ...}: inputs');
        };

        modules = [
          {networking.hostName = name;}
          inputs.self.modules.nixos.${name}
        ];
      };
    };

    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;

    applyTheme = config: app:
      config.scheme {
        template = builtins.readFile "${inputs.dots}/${app}/base16.mustache";
      };
  };
}
