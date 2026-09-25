{self, ...}: {
  flake.nixosModules.laptop = {
    imports = [
      # Role
      self.nixosModules.desktop

      # Hardware
      self.nixosModules.battery
      self.nixosModules.bluetooth
    ];
  };
}
