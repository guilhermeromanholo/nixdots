{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "vortex";
    system = "x86_64-linux";
  };

  flake.nixosModules.vortex = {
    imports = [
      self.nixosModules.wsl
      self.nixosModules.guilherme
    ];
  };
}
