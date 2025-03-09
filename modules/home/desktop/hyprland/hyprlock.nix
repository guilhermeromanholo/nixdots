{
  lib,
  config,
  ...
}: let
  cfg = config.modules.desktop.hyprland.hyprlock;
in {
  options.modules.desktop.hyprland.hyprlock = {
    enable = lib.mkEnableOption "Hyprlock";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}
