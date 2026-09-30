{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos {
    name = "vortex";
    system = "x86_64-linux";
  };

  flake.nixosModules.vortex = {
    imports = with inputs; [
      # Modules
      self.nixosModules.base
      self.nixosModules.guilherme

      # WSL
      nixos-wsl.nixosModules.default
    ];

    wsl.enable = true;
    wsl.usbip.enable = true;
  };
}
