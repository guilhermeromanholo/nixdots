{ self, inputs, ... }: {
  flake.modules.nixos.vortex = { ... }: {
    imports = [
      self.modules.nixos.terminal
      inputs.nixos-wsl.nixosModules.wsl
    ];
    networking.hostName = "vortex";
    system.stateVersion = "24.11";
    nixdots.theme = self.themes.nord;
    wsl = {
      enable = true;
      defaultUser = "guilherme";
      usbip.enable = true;
      startMenuLaunchers = true;
    };
  };
}
