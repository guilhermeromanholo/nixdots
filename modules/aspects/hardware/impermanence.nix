{ inputs, ... }:
{
  den.aspects.impermanence = {
    nixos =
      {
        host,
        persist,
        lib,
        ...
      }:
      {
        imports = [
          inputs.impermanence.nixosModules.impermanence
        ];

        environment.persistence."/persist" = {
          hideMounts = true;

          files = [
            "/etc/adjtime"
            "/etc/machine-id"
          ]
          ++ (lib.unique (lib.concatMap (e: e.root.files or [ ]) persist));

          directories = [
            "/var/log"
            "/var/lib/nixos"
          ]
          ++ (lib.unique (lib.concatMap (e: e.root.directories or [ ]) persist));

          users = lib.genAttrs (builtins.attrNames host.users) (_user: {
            files = lib.unique (lib.concatMap (e: e.user.files or [ ]) persist);
            directories = lib.unique (lib.concatMap (e: e.user.directories or [ ]) persist);
          });
        };
      };
  };
}
