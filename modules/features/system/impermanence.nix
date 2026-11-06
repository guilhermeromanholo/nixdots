{ inputs, lib, ... }:
{
  flake.modules.nixos.impermanence = { config, ... }: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      hideMounts = true;

      files = [
        "/etc/adjtime"
        "/etc/machine-id"
      ]
      ++ config.persist.root.files;

      directories = [
        "/var/log"
        "/var/lib/nixos"
      ]
      ++ config.persist.root.directories;

      users = lib.mapAttrs (_: _: { inherit (config.persist.user) directories files; }) (
        lib.filterAttrs (_: user: user.isNormalUser) config.users.users
      );
    };
  };
}
