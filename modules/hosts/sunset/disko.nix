{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = [
      (self.lib.disko {
        device = "/dev/nvme0n1";
        size = "795G";
        swap = "16G";
      })
    ];
  };
}
