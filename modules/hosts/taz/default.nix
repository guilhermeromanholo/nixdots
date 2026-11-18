{ self, ... }:
{
  flake.nixosConfigurations.taz = self.lib.mkNixos {
    name = "taz";

    modules = with self.nixosModules; [
      taz
      desktop
    ];
  };
}
