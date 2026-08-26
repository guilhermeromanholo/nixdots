{
  inputs,
  lib,
  ...
}: {
  flake.lib = {
    # Function used to create a system with the
    # host module located in modules/hosts.
    mkNixos = {
      name,
      system,
      version,
    }: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          {networking.hostName = name;}
          {system.stateVersion = version;}
          {nixpkgs.hostPlatform = lib.mkDefault system;}
        ];
      };
    };

    # Function to check if a group added to a
    # user exists within the host's context.
    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;

    # Function to check if impermanence is enabled
    # on the host being evaluated.
    mkIfPersistence = config: settings: (
      if config.environment ? persistence
      then settings
      else {}
    );
  };
}
