{self, ...}: {
  flake.modules.nixos.sunset = {
    imports = [
      (self.factory.disk {
        device = "/dev/nvme0n1";
        size = "795G";
        swap = "16G";
      })
    ];
  };
}
