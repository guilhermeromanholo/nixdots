{ self, ... }:
{
  flake.nixosModules.sunset = {
    imports = with self.nixosModules; [
      # Roles
      desktop

      # Hardware
      sunset-hardware
    ];
  };

  flake.nixosConfigurations.sunset = self.lib.mkNixos {
    name = "sunset";
    modules = [ self.nixosModules.sunset ];
  };
}
