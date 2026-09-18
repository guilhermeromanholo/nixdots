{self, ...}: {
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      # Role
      cli

      # System
      boot
      audio

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
