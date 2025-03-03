{
  lib,
  config,
  ...
}: let
  cfg = config.modules.hardware.ssd;
in {
  options.modules.hardware.ssd = {
    enable = lib.mkEnableOption "SSD";
  };

  config = lib.mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}
