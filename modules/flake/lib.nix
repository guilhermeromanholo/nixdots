{
  inputs,
  lib,
  withSystem,
  ...
}: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config.flake.lib = {
    # Create NixosConfigurations with evaluated
    # self packages in specialArgs
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

    # Persist selected directories and files if
    # impermanence is enabled
    mkIfPersistence = config: settings:
      if config.environment ? persistence
      then {persistence."/persist" = settings;}
      else {};

    # Add a group to user if the group exists
    #  in the configuration
    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;

    # Apply flake.theme to my custom packages
    # and modules
    applyTheme = path: pkgs: let
      base16Lib = pkgs.callPackage inputs.base16.lib {};
      scheme = base16Lib.mkSchemeAttrs inputs.self.theme.scheme;
    in
      scheme {template = builtins.readFile path;};
  };
}
