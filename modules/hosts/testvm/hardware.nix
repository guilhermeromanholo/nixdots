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

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
