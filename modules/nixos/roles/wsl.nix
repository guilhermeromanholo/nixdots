{inputs, ...}: {
  flake.nixosModules.wsl = {
    imports = with inputs; [
      # System
      self.nixosModules.core

      # WSL
      nixos-wsl.nixosModules.default
    ];

    wsl.enable = true;
    wsl.usbip.enable = true;
  };
}
