{self, ...}: {
  flake.modules.nixos.boot = self.lib.mkModule {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
