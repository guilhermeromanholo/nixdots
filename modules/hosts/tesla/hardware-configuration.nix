{inputs, ...}: {
  hosts.nixos.tesla = {
    disk = {
      size = "100%";
      swap = "8G";
      device = "/dev/nvme0n1";
    };

    module = {
      imports = with inputs; [
        self.modules.nixos.disko
        nixos-hardware.nixosModules.lenovo-thinkpad-t480
      ];

      boot.kernelModules = [
        "kvm-intel"
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "sd_mod"
        "xhci_pci"
        "usb_storage"
      ];
    };
  };
}
