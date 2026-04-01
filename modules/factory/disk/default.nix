{
  config.flake.factory.disko = {
    device,
    swap,
  }: {
    disko.devices = {
      disk.main = {
        type = "disk";
        inherit device;

        content = {
          type = "gpt";

          partitions = {
            # UEFI
            esp = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };

            # Swap
            swap = {
              size = swap;
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };
          };
        };
      };
    };
  };
}
