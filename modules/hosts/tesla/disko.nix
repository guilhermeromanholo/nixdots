{self, ...}: {
  flake.modules.nixos.tesla.imports = [
    (self.factory.disko {
      size = "100%";
      swap = "8G";
      device = "/dev/nvme0n1";
    })
  ];
}
