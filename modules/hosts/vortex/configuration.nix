{self, ...}: {
  flake.nixosConfigurations = self.lib.mkNixos {
    arch = "x86_64-linux";
    name = "vortex";
    version = "26.11";
  };

  flake.modules.nixos.vortex = {
    imports = with self.modules.nixos; [
      system-base
      wsl
    ];
  };
}
