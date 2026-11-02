{ self, ... }:
{
  flake.modules.nixos.workstation = {
    imports = with self.modules.nixos; [
      # Profile
      base

      # Hardware
      ssd
      graphics
      firmware

      # Services
      openssh
      printing
      tailscale
    ];
  };
}
