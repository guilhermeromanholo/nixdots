{
  flake.factory.disko = {
    size ? "100%",
    swap ? "4G",
    device ? "/dev/sda",
  }: {
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    disko.devices = {
      disk.main = {
        type = "disk";
        content.type = "gpt";
        inherit device;
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
        name = "root";
        inherit size;

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
