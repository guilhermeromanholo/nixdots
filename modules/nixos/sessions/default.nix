{
  lib,
  config,
  ...
}: let
  cfg = config.modules.sessions;
in {
  imports = [
    ./sway
    ./gnome
    ./hyprland
  ];

  options.modules.sessions = {
    enable = lib.mkEnableOption "Sessions";
  };

  config = lib.mkIf cfg.enable {
    # Enable X11
    services.xserver.enable = true;
    # Enable OpenGL
    hardware.graphics.enable = true;
    # Login Manager
    services.xserver.displayManager.gdm.enable = true;
  };
}
