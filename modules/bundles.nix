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

    desktop.imports = [
      base

      boot
      audio

      podman
      openssh
      printing
      tailscale
    ];

    laptop.imports = [
      desktop

      power
      bluetooth
    ];
  };
}
