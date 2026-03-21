{
  flake.modules.nixos.testvm = {
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.kernelModules = ["kvm-amd"];
    boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk"];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/544a9352-b2f5-4bd7-ac4b-2ac98a87e3a0";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/691C-7894";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
