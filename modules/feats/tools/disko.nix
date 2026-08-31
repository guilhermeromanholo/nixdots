{inputs, ...}: {
  flake.factory.disko = {
    size,
    swap,
    device,
    ...
  }: {
    imports = [inputs.disko.nixosModules.disko];

    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    disko.devices = {
      disk.main = {
        type = "disk";
        inherit device;
        content.type = "gpt";
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
        size = swap;

        content = {
          type = "swap";
          discardPolicy = "both";
        };
      };

      disk.main.content.partitions.root = {
        inherit size;
        name = "root";

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
}
