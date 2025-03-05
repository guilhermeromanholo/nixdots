{
  disko.devices = {
    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";

      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "8G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
            size = "200G";
            content = {
              type = "lvm_pv";
              vg = "root_vg";
            };
          };
        };
      };
    };

    lvm_vg.root_vg = {
      type = "lvm_vg";

      lvs = {
        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];

            subvolumes = {
              "/persist" = {
                mountOptions = ["subvol=persist" "noatime"];
                mountpoint = "/persist";
              };

              "/nix" = {
                mountOptions = ["subvol=nix" "noatime"];
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };

    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=2G"
        ];
      };

      "/home" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=12G"
        ];
      };
    };
  };
}
