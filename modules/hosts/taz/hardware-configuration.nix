{ self, ... }:
{
  flake.aspects.taz = {
    includes = [
      (self.aspects.disko {
        size = "100%";
        swap = "8G";
        device = "/dev/sda";
      })
    ];

    nixos = {
      imports = with self.inputs; [
        nixos-hardware.nixosModules.common-pc
        nixos-hardware.nixosModules.common-pc-ssd
        nixos-hardware.nixosModules.common-cpu-intel
      ];

      boot.initrd.availableKernelModules = [
        "ahci"
        "usbhid"
        "sd_mod"
        "xhci_pci"
      ];

      boot.kernelModules = [ "kvm-intel" ];
    };
  };
}
