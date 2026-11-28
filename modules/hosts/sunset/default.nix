{ self, ... }:
{
  flake.nixosConfigurations.sunset = self.lib.mkNixos {
    name = "sunset";
    version = "26.11";
  };

  flake.modules.nixos.sunset = {
    imports = with self.modules.nixos; [
      workstation
    ];
  };
}
