{ self, ... }:
{
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "vortex";
    system = "x86_64-linux";
  };

  flake.aspects.vortex = {
    includes = with self.aspects; [
      wsl
      base
      guilherme
    ];

    nixos.wsl.defaultUser = "guilherme";
  };
}
