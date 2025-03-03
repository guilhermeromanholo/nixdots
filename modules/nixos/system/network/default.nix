{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.network;
in {
  options.modules.system.network = {
    enable = lib.mkEnableOption "Network";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
    };
  };
}
