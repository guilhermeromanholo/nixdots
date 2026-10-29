{
  den.aspects.sunset.nixos = {
    fileSystems."/" = {
      device = "tmpfs";
      fsType = "tmpfs";
    };

    boot.initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "usbhid"
      "xhci_pci"
    ];

    boot.kernelModules = [
      "kvm-amd"
    ];

    hardware.cpu.amd.updateMicrocode = true;
  };
}
