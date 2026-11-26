{ lib, ... }:
{
  flake.nixosModules.taz-hardware = {
    key = "nixdots:modules/hosts/taz/hardware.nix:taz-hardware";

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
