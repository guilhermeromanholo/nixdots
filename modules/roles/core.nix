{ self, ... }:
{
  flake.nixosModules.core = {
    imports = with self.nixosModules; [
      nix
      boot
      users
      locale
      nixpkgs
    ];
  };
}
