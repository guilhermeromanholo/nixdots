{ self, ... }:
{
  flake.modules.nixos.sunset = {
    imports = with self.modules.nixos; [
      ssd
      disko
    ];

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
