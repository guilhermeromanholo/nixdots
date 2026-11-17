{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      core
      boot
      network
      options
    ];
  };
}
