{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos {
    name = "tesla";
    version = "26.11";
    system = "x86_64-linux";
  };

  flake.modules.nixos.tesla = {
    imports = with self.modules.nixos; [
      # Role
      desktop

      # Users
      guilherme

      # Tools
      impermanence
    ];
  };
}
