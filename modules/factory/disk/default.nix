{lib, ...}: {
  config.flake.factory.disko = {
    device,
    size,
    swap,
    tmpfs ? false,
  }: {
    disko.devices = lib.mkMerge [
      {
        disk.main = {
          type = "disk";
          inherit device;

          content = {
            type = "gpt";
            partitions = {
              esp = {
                size = "1G";
                type = "EF00";

                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };

              swap = {
                size = swap;

                content = {
                  type = "swap";
                  discardPolicy = "both";
                };
              };

              root = {
                inherit size;

                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];

                  subvolumes = {
                    "/nix" = {
                      mountpoint = "/nix";
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
        };
      }

      (
        lib.mkIf (!tmpfs) {
          disk.main = {
            content.partitions = {
              root.content.subvolumes."/root" = {
                mountpoint = "/";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
            };
          };
        }
      )

      (
        lib.mkIf tmpfs {
          nodev."/" = {
            fsType = "tmpfs";
            mountOptions = [
              "defaults"
              "size=20%"
              "mode=755"
            ];
          };

          disk.main = {
            content.partitions = {
              root.content.subvolumes."/persist" = {
                mountpoint = "/persist";
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
            };
          };
        }
      )
    ];
  };
}
