{
  flake.nixosModules.taz = {
    fileSystems."/".fsType = "tmpfs";
    fileSystems."/".device = "/dev/null";

    boot.initrd.availableKernelModules = [
      "ahci"
      "sd_mod"
      "usbhid"
      "xhci_pci"
    ];

    boot.kernelModules = [
      "kvm-intel"
    ];

    hardware.cpu.intel.updateMicrocode = true;
  };
}
