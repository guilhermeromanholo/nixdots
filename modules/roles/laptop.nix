{ self, ... }:
{
  flake.nixosModules.laptop.key = "nixdots:modules/roles/laptop.nix:laptop";
  flake.nixosModules.laptop.imports = with self.nixosModules; [
    workstation
    power
    bluetooth
  ];
}
