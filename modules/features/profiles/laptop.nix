{ self, ... }:
{
  flake.modules.nixos.laptop = {
    imports = with self.modules.nixos; [
      # Profile
      workstation

      # Services
      avahi

      # Hardware
      battery
      bluetooth
    ];
  };
}
