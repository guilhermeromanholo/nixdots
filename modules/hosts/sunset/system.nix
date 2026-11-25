{ lib, ... }:
{
  flake.nixosModules.sunset = {
    networking.hostName = "sunset";
    system.stateVersion = "26.11";

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
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
