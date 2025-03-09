{
  lib,
  config,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
in {
  imports = [
    ./config.nix
    ./hyprlock.nix
    ./hyprpanel.nix
  ];

  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf cfg.enable {
    modules.desktop.hyprland = {
      config.enable = true;
      hyprlock.enable = true;
      hyprpanel.enable = true;
    };
  };
}
