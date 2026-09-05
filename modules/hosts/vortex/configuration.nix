{self, ...}: {
  flake.nixosConfigurations = {
    vortex = self.inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.modules.nixos.vortex];
    };
  };

  flake.modules.nixos.vortex = {
    imports = with self.modules.nixos; [
      base
      wsl
    ];

    system.stateVersion = "26.11";
    networking.hostName = "vortex";
  };
}
