{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.disko = {config, ...}: {
    imports = [inputs.disko.nixosModules.disko];

    options.disk = {
      size = lib.mkOption {type = lib.types.str;};
      swap = lib.mkOption {type = lib.types.str;};
      device = lib.mkOption {type = lib.types.str;};
    };

    config = {
      fileSystems."/nix".neededForBoot = true;
      fileSystems."/persist".neededForBoot = true;

      disko.devices = {
        disk.main = {
          type = "disk";
          content.type = "gpt";
          inherit (config.disk) device;
        };

        nodev."/" = {
          fsType = "tmpfs";
          mountOptions = ["size=20%" "mode=755"];
        };

        disk.main.content.partitions.esp = {
          name = "ESP";
          size = "1G";
          type = "EF00";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };

        disk.main.content.partitions.swap = {
          size = config.disk.swap;

          content = {
            type = "swap";
            discardPolicy = "both";
          };
        };

        disk.main.content.partitions.root = {
          name = "root";
          inherit (config.disk) size;

          content.type = "btrfs";
          content.extraArgs = ["-f"];

          content.subvolumes = {
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = ["compress=zstd" "noatime"];
            };

            "/persist" = {
              mountpoint = "/persist";
              mountOptions = ["compress=zstd" "noatime"];
            };
          };
        };
      };
    };
  };
}
