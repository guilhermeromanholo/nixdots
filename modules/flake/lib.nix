{
  inputs,
  lib,
  ...
}: {
  flake.lib = {
    #---------#
    #  NixOS  #
    #---------#
    mkNixos = {
      name,
      arch,
      version,
    }: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          {
            networking.hostName = name;
            system.stateVersion = version;
            nixpkgs.hostPlatform = lib.mkDefault arch;
          }
        ];
      };
    };

    #---------#
    #  Utils  #
    #---------#
    mkIfPersistence = config: settings: (
      if config.environment ? persistence
      then {persistence."/persist" = settings;}
      else {}
    );

    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;
  };
}
