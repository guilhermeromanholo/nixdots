{
  flake.modules.nixos.sunset = {
    fileSystems."/".fsType = "tmpfs";
    fileSystems."/".device = "/dev/null";

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
