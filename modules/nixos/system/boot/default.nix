{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.boot;
in {
  options.modules.system.boot = {
    enable = lib.mkEnableOption "Boot";

    uefi = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/sda";
    };

    os-prober = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      # Default
      enable = true;
      useOSProber = cfg.os-prober;

      # BIOS
      device = cfg.device;

      # Uefi
      efiSupport = cfg.uefi;
      efiInstallAsRemovable = cfg.uefi;
    };
  };
}
