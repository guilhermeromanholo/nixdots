{inputs, ...}: {
  flake.modules.nixos.tesla = {
    imports = with inputs; [
      nixos-hardware.nixosModules.lenovo-thinkpad-t480
    ];

    boot.kernelModules = [
      "kvm-intel"
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "sd_mod"
      "xhci_pci"
      "usb_storage"
    ];
  };
}
