{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.external.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.modules.external.impermanence = {
    enable = lib.mkEnableOption "Impermanence";

    path = lib.mkOption {
      type = lib.types.str;
      default = "/persist";
    };

    dirs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };

    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    programs.fuse.userAllowOther = true;

    fileSystems = {
      "/home".neededForBoot = true;
      ${cfg.path}.neededForBoot = true;
    };

    environment = {
      etc."shadow".source = "${cfg.path}/system/etc/shadow";

      persistence."${cfg.path}/system" = {
        hideMounts = true;

        directories =
          cfg.dirs
          ++ [
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
          ];

        files =
          cfg.files
          ++ [
            "/etc/shadow"
            "/etc/machine-id"
          ];
      };
    };
  };
}
