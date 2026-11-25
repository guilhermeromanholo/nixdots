{ lib, ... }:
{
  flake.nixosModules.tesla = { pkgs, ... }: {
    networking.hostName = "tesla";
    system.stateVersion = "26.05";

    settings.user.name = "guilherme";

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/bca7dfec-2b73-4aad-acff-17b704d5db43";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/F576-F303";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/2b002b7d-068c-4595-93f5-1302c7e4bb39"; }
    ];

    environment.systemPackages = [ pkgs.firefox ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
      "xhci_pci"
      "usb_storage"
    ];

    boot.kernelModules = [
      "kvm-intel"
    ];

    hardware.cpu.intel.updateMicrocode = true;
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
