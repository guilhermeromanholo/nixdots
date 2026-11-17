{ self, ... }:
{
  flake.nixosModules.core = {
    imports = with self.nixosModules; [
      nix
      user
      locale
      nixpkgs
      security
    ];
  };
}
