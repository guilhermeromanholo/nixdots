{ self, ... }:
{
  flake.modules.nixos = with self.modules.nixos; {
    base.imports = [
      nix
      users
      locale
      network
      options
    ];

    workstation.imports = [
      base

      # System
      boot
      audio
      firmware

      # Service
      podman
      openssh
      printing
      tailscale
    ];

    laptop.imports = [
      workstation

      # Service
      power
      bluetooth
    ];
  };
}
