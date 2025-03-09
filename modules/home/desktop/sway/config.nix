{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.sway.config;
in {
  options.modules.desktop.sway.config = {
    enable = lib.mkEnableOption "Sway config";

    modKey = lib.mkOption {
      type = lib.types.str;
      default = "Mod4";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;

      xwayland = true;
      systemd.enable = true;

      checkConfig = false;

      config = {
        modifier = cfg.modKey;

        bars = lib.mkIf config.programs.waybar.enable [];
        menu = lib.mkIf config.programs.wofi.enable "${pkgs.wofi}/bin/wofi";

        terminal = "${pkgs.kitty}/bin/kitty";

        gaps = {
          inner = 6;
          outer = 4;
        };

        input = {
          "*" = {
            xkb_layout = "br";
          };
        };

        keybindings = lib.mkOptionDefault {
          "Ctrl+Alt+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";
          "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area";
        };
      };

      extraConfig = ''
        # Remove title
        default_border pixel

        # Start workspace
        workspace 1

        # Wofi Rule
        for_window [app_id="wofi"] {
          floating enable
          border pixel
          resize set width 100ppt
          resize set height 100ppt
          move position -20 -30
          resize set width 30ppt
          resize set height 50ppt
        }

        # SwayFX Config
        corner_radius 10
        blur enable
        blur_passes 4
        blur_radius 2
      '';
    };
  };
}
