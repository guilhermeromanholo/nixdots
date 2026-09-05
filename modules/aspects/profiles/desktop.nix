{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      # Profile
      base

      # System
      boot
      audio
      graphics

      # Hardware
      ssd
      firmware

      # Services
      openssh
      printing
      tailscale
    ];
  };
}
