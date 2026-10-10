{ self, ... }:
{
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "sunset";
    system = "x86_64-linux";
  };

  flake.aspects.sunset = {
    includes = with self.aspects; [
      desktop
      guilherme
      impermanence
    ];
  };
}
