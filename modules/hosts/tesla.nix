{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "tesla";
    version = "26.11";
    system = "x86_64-linux";
  };

  flake.modules.nixos.tesla = {
    imports = with self.modules.nixos; [
      # Role
      desktop

      # Tools
      impermanence

      (self.factory.disko {
        size = "100%";
        swap = "8G";
        device = "/dev/nvme0n1";
      })
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
      "xhci_pci"
      "usb_storage"
    ];

    boot.kernelModules = ["kvm-intel"];
    hardware.cpu.intel.updateMicrocode = true;
  };
}
