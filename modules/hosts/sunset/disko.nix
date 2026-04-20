{self, ...}: {
  flake.modules.nixos.sunset = {
    imports = [
      (self.lib.mkDisko {
        device = "/dev/nvme0n1";
        size = "795G";
        swap = "16G";
      })
    ];
  };
}
