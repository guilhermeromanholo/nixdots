{ self, ... }:
{
  flake.nixosModules.network = {
    imports = with self.nixosModules; [
      openssh
      tailscale
      networkmanager
    ];
  };
}
