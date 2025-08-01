{
  lib,
  config,
  pkgs,
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

    xkbmap = lib.mkOption {
      type = lib.types.str;
      default = "br";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable X11
    services.xserver.enable = true;
    services.xserver.xkb.layout = cfg.xkbmap;

    # Enable OpenGL
    hardware.graphics.enable = true;

    # Login Manager
    # services.xserver.displayManager.gdm.enable = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --user-menu \
            --remember \
            --remember-user-session \
            --asterisks \
            --window-padding 1 \
            --container-padding 2 \
            --prompt-padding 2
          '';
          # --cmd "Hyprland > /dev/null"
          user = "greeter";
        };
      };
    };
  };
}
