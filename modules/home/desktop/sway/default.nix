{
  lib,
  config,
  ...
}: let
  cfg = config.modules.desktop.sway;
in {
  imports = [
    ./config.nix
    ./waybar.nix
    ./swaylock.nix
  ];

  options.modules.desktop.sway = {
    enable = lib.mkEnableOption "Sway";
  };

  config = lib.mkIf cfg.enable {
    modules.desktop.sway = {
      config.enable = true;
      waybar.enable = true;
      swaylock.enable = true;
    };
  };
}
