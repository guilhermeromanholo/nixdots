{self, ...}: {
  flake.nixosModules.laptop = {
    imports = [
      self.nixosModules.desktop
      self.nixosModules.bluetooth
    ];

    # Battery
    services.tlp.enable = true;
    powerManagement.enable = true;
    services.thermald.enable = true;
  };
}
