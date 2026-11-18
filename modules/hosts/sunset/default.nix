{ self, ... }:
{
  flake.nixosConfigurations.sunset = self.lib.mkNixos {
    name = "sunset";

    modules = with self.nixosModules; [ 
      sunset
      desktop
    ];
  };
}
