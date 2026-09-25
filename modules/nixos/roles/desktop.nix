{self, ...}: {
  flake.nixosModules.desktop = {self', ...}: {
    imports = [
      # System
      self.nixosModules.core
      self.nixosModules.boot

      # Hardware
      self.nixosModules.audio
      self.nixosModules.printer
      self.nixosModules.firmware

      # Network
      self.nixosModules.ssh
      self.nixosModules.tailscale
    ];

    programs.mango = {
      enable = true;
      # package = self'.packages.mango;
    };

    programs.noctalia = {
      enable = true;
      package = self'.packages.noctalia;
    };
  };
}
