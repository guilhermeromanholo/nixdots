{ self, inputs, ... }: {
  flake.modules.nixos.persistence =
    { config, lib, ... }:
    let
      cfg = config.nixdots.persistence;
    in
    {
      imports = [
        inputs.impermanence.nixosModules.impermanence
        self.modules.nixos.persistence-contract
      ];
      config = lib.mkIf cfg.enable {
        fileSystems.${cfg.root}.neededForBoot = true;
        fileSystems."/home".neededForBoot = true;
        # Keep the old physical layout: /persist/system and /persist/home/guilherme.
        environment.persistence."${cfg.root}/system" = {
          hideMounts = true;
          directories = [
            "/var/log"
            "/var/lib/bluetooth"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager/system-connections"
            {
              directory = "/var/lib/colord";
              user = "colord";
              group = "colord";
              mode = "u=rwx,g=rx,o=";
            }
          ]
          ++ cfg.systemDirectories;
          files = [
            "/etc/machine-id"
            "/etc/shadow"
          ];
        };
        environment.etc.shadow.source = "${cfg.root}/system/etc/shadow";
        environment.persistence.${cfg.root}.users.${config.nixdots.user.name} = {
          directories = cfg.userDirectories;
          files = cfg.userFiles;
        };
      };
    };
}
