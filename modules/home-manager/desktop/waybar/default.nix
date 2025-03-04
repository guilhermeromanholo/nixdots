{
  lib,
  config,
  ...
}: let
  cfg = config.modules.desktop.waybar;
in {
  imports = [
    ./config.nix
    ./modules.nix
  ];

  options.modules.desktop.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
        target = "sway-session.target";
      };
    };
  };
}
