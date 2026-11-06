{ inputs, ... }:
{
  flake.modules.nixos.disko = { config, ... }: {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    config = {
      fileSystems."/nix".neededForBoot = true;
      fileSystems."/persist".neededForBoot = true;

      disko.devices.nodev."/" = {
        fsType = "tmpfs";

        mountOptions = [
          "size=20%"
          "mode=755"
        ];
      };

      disko.devices.disk.main = {
        type = "disk";
        content.type = "gpt";
        inherit (config.settings.disk) device;

        content.partitions.esp = {
          name = "ESP";
          size = "1G";
          type = "EF00";

          content.type = "filesystem";
          content.format = "vfat";
          content.mountpoint = "/boot";
        };

        content.partitions.root = {
          name = "root";
          inherit (config.settings.disk) size;

          content.type = "btrfs";
          content.extraArgs = [ "-f" ];

          content.subvolumes = {
            "/nix" = {
              mountpoint = "/nix";

              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };

            "/persist" = {
              mountpoint = "/persist";

              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
          };
        };

        content.partitions.swap = {
          size = config.settings.disk.swap;

          content.type = "swap";
          content.discardPolicy = "both";
        };
      };
    };
  };
}
