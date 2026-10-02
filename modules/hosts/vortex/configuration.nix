{inputs, ...}: {
  flake.nixosConfigurations = inputs.self.lib.mkNixos {
    name = "vortex";
    system = "x86_64-linux";
  };

  flake.modules.nixos.vortex = {
    imports = with inputs; [
      # Modules
      self.modules.nixos.base
      self.modules.nixos.guilherme

      # WSL
      nixos-wsl.nixosModules.default
    ];

    wsl = {
      enable = true;
      usbip.enable = true;
      defaultUser = "guilherme";
    };
  };
}
