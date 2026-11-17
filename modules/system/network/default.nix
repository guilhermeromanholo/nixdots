{ self, ... }:
{
  flake.nixosModules.network = {
    imports = with self.nixosModules; [
      openssh
      networkmanager
    ];
  };
}
