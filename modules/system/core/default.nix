{ self, ... }:
{
  flake.nixosModules.core = {
    imports = with self.nixosModules; [
      nix
      user
      boot
      locale
      nixpkgs
    ];
  };
}
