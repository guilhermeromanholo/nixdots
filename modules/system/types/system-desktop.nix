{self, ...}: {
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      # Type
      system-base

      # Settings
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
