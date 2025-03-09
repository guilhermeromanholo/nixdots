{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.sway.swaylock;
in {
  options.modules.desktop.sway.swaylock = {
    enable = lib.mkEnableOption "Swaylock";
  };

  config = lib.mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        indicator = true;
        indicator-radius = 128;

        daemonize = true;
        font-size = 48;

        clock = true;
        datestr = "%a, %B %e";
        timestr = "%H:%M %p";

        fade-in = 1;
        effect-blur = "15x15";
        effect-vignette = "1:1";
      };
    };
  };
}
