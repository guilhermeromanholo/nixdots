{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = [
      (self.factory.disko {
        device = "/dev/vda";
        size = "100%";
        swap = "2G";
        tmpfs = true;
      })
    ];
  };
}
