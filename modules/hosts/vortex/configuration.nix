{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "vortex";
    system = "x86_64-linux";
  };

  flake.modules.nixos.vortex = {
    imports = with self.modules.nixos; [
      # Role
      cli

      # Tools
      wsl

      # Users
      guilherme
    ];

    wsl.defaultUser = "guilherme";
    system.stateVersion = "26.11";
  };
}
