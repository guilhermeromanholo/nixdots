{ lib, ... }:
{
  flake.nixosModules.sunset-hardware = {
    key = "nixdots:modules/hosts/sunset/hardware.nix:sunset-hardware";

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
