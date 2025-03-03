{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.hardware.printer;
in {
  options.modules.hardware.printer = {
    enable = lib.mkEnableOption "Printer";

    drivers = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      # Enable CUPS
      printing = {
        enable = true;
        drivers = with pkgs; cfg.drivers;
      };
      # Enable Network Discover
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };
    # Enable Scanner
    hardware.sane.enable = true;
  };
}
