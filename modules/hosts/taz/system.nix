{ lib, ... }:
{
  flake.nixosModules.taz = {
    networking.hostName = "taz";
    system.stateVersion = "26.11";

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
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
