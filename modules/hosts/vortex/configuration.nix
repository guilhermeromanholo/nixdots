{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "vortex";
    version = "26.11";
    system = "x86_64-linux";
  };

  flake.modules.nixos.vortex = {
    imports = with self.modules.nixos; [
      # Role
      base

      # Tools
      wsl

      # Users
      guilherme
    ];

    wsl.defaultUser = "guilherme";
  };
}
