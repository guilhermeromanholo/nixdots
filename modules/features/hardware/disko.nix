{ inputs, ... }:
{
  flake.modules.nixos.disko = { config, lib, ... }: {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    options.dots.disk = {
      size = lib.mkOption {
        type = lib.types.str;
        description = "Size of the root partition.";
      };

      device = lib.mkOption {
        type = lib.types.str;
        description = "Disk device partitioned by disko.";
      };

      swap = lib.mkOption {
        type = lib.types.str;
        description = "Size of the swap partition.";
      };
    };

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
        inherit (config.dots.disk) device;

        content.partitions.esp = {
          name = "ESP";
          size = "1G";
          type = "EF00";

          content.type = "filesystem";
          content.format = "vfat";
          content.mountpoint = "/boot";
        };

        content.partitions.swap = {
          size = config.dots.disk.swap;

          content.type = "swap";
          content.discardPolicy = "both";
        };

        content.partitions.root = {
          name = "root";
          inherit (config.dots.disk) size;

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
      };
    };
  };
}
