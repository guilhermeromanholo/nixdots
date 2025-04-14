{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.sway.swayidle;
in {
  options.modules.desktop.sway.swayidle = {
    enable = lib.mkEnableOption "Swayidle";
  };

  config = lib.mkIf cfg.enable {
    services.swayidle = {
      enable = true;
      timeouts = let
        swayMsg = "${pkgs.sway}/bin/swaymsg";
      in [
        {
          timeout = 360;
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
        {
          timeout = 720;
          command = ''${swayMsg} "output * power off"'';
          resumeCommand = ''${swayMsg} "output * power on"'';
        }
      ];
    };
  };
}
