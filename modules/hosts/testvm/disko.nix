{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = [
      self.modules.nixos.disko

      (self.factory.disko {
        device = "/dev/vda";
        swap = "2G";
      })
    ];

    disko.devices.disk.main.content.partitions = {
      root = {
        name = "ROOT";
        size = "100%";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/";
        };
      };
    };
  };
}
