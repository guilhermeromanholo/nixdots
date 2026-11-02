{ self, ... }:
{
  flake.modules.nixos.base = {
    imports = with self.modules.nixos; [
      nix
      boot
      locale
      nixpkgs
      network
      security
    ];
  };
}
