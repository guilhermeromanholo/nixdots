{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      # Role
      base

      # Core
      boot
      audio

      # Hardware
      ssd
      firmware
      graphics

      # Services
      ssh
      printing
      tailscale
    ];
  };
}
