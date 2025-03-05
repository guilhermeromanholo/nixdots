{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.impermanence;
in {
  imports = [
    ../shared
    inputs.impermanence.nixosModules.impermanence
  ];

  config = lib.mkIf cfg.enable {
    programs.fuse.userAllowOther = true;

    fileSystems.${cfg.persistPath}.neededForBoot = true;
    fileSystems."/home".neededForBoot = true;

    environment.persistence."${cfg.persistPath}/system" = {
      hideMounts = true;

      directories =
        [
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
        ++ cfg.directories;

      files =
        [
          "/etc/machine-id"
        ]
        ++ cfg.files;
    };
  };
}
