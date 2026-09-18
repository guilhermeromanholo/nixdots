{self, ...}: {
  configurations.nixos.taz.module = {lib, ...}: {
    imports = [
      (self.factory.disko {
	size = "100%";
	swap = "6G";
	device = "/dev/sda";
      })
    ];

    boot.kernelModules = ["kvm-intel"];

    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
    ];

    hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
  };
}
