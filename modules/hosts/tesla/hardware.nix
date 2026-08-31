{
  flake.modules.nixos.tesla = {
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
