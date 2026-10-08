{ self, ... }:
{
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "taz";
    system = "x86_64-linux";
  };

  flake.aspects.taz = {
    includes = with self.aspects; [
      desktop
      guilherme
    ];
  };
}
