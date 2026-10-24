{self, ...}: {
  hosts.nixos.tesla = {
    version = "26.11";
    system = "x86_64-linux";

    disk.size = "100%";
    disk.swap = "8G";
    disk.device = "/dev/nvme0n1";
  };

  flake.modules.nixos.tesla = {
    imports = with self.modules.nixos; [
      laptop
      disko
    ];
  };
}
