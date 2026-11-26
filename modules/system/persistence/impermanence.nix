{ inputs, self, ... }:
{
  flake.nixosModules.impermanence = { config, ... }: {
    key = "nixdots:modules/system/persistence/impermanence.nix:impermanence";
    imports = [
      self.nixosModules.persist-options
      self.nixosModules.user-options
      inputs.impermanence.nixosModules.impermanence
    ];

    persist.root = {
      files = [ "/etc/machine-id" ];
      directories = [ "/var/lib/nixos" ];
    };

    environment.persistence.${config.persist.storagePath} = {
      hideMounts = true;
      inherit (config.persist.root) files directories;
      users.${config.settings.user.name} = {
        inherit (config.persist.user) files directories;
      };
    };

    assertions = [
      {
        assertion =
          builtins.hasAttr config.persist.storagePath config.fileSystems
          && config.fileSystems.${config.persist.storagePath}.neededForBoot;
        message = "Mount persist.storagePath on persistent storage and set neededForBoot = true before importing impermanence.";
      }
    ];
  };
}
