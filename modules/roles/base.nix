{ self, ... }:
{
  flake.nixosModules.base.key = "nixdots:modules/roles/base.nix:base";
  flake.nixosModules.base.imports = with self.nixosModules; [
    user-options
    theme-options
    persist-options
    session-options
    nix
    nixpkgs
    locale
    users
  ];
}
