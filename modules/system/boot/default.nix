{
  flake.modules.nixos.boot = {config, ...}: {
    boot.loader.grub = let
      cfg = config.settings;
    in {
      # Default
      enable = true;
      useOSProber = cfg.osProber;

      # BIOS
      device = cfg.bootDevice;

      # Uefi
      efiSupport = cfg.uefi;
      efiInstallAsRemovable = cfg.uefi;
    };
  };
}
