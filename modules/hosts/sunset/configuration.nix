{ self, ... }:
{
  flake.nixosModules.sunset = {
    imports = with self.nixosModules; [
      desktop
      sunset-hardware
    ];
  };

  flake.nixosConfigurations.sunset = self.lib.mkNixos {
    name = "sunset";
    modules = [ self.nixosModules.sunset ];
  };
}
