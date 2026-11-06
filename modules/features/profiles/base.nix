{ self, ... }:
{
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      # System
      nix
      boot
      locale
      network
      nixpkgs
      security

      # Contracts
      persist
      settings
    ];
  };
}
