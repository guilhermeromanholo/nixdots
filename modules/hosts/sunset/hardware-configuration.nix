{ self, ... }:
{
  flake.aspects.sunset = {
    includes = [
      (self.aspects.disko {
        size = "465G";
        swap = "4G";
        device = "/dev/nvme0n1";
      })
    ];

    nixos = {
      imports = with self.inputs; [
        nixos-hardware.nixosModules.common-pc
        nixos-hardware.nixosModules.common-pc-ssd
        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-gpu-amd
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "ahci"
        "usbhid"
        "xhci_pci"
      ];

      boot.kernelModules = [ "kvm-amd" ];
    };
  };
}
