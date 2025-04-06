{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland.config;
in {
  options.modules.desktop.hyprland.config = {
    enable = lib.mkEnableOption "Hyprland config";

    modKey = lib.mkOption {
      type = lib.types.str;
      default = "SUPER";
    };

    kb_layout = lib.mkOption {
      type = lib.types.str;
      default = "br";
    };
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor.hyprcursor.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        general = {
          "$mainMod" = cfg.modKey;
          gaps_in = 4;
          gaps_out = 8;
        };

        input = {
          kb_layout = cfg.kb_layout;
        };

        decoration = {
          blur = {
            enabled = true;
            size = 4;
            passes = 2;
            vibrancy = 0.1696;
          };
        };

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        bind = [
          "Ctrl+Alt, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
          "$mainMod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
          "$mainMod, D, exec, ${pkgs.wofi}/bin/wofi"
          "$mainMod+Shift, Space, togglefloating"
          "$mainMod+Shift, Q, killactive"
          "$mainMod, W, togglegroup"
          "$mainMod, F, fullscreen"
          "$mainMod, M, exit"

          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          "$mainMod+Ctrl, H, resizeactive, -40 0"
          "$mainMod+Ctrl, L, resizeactive, 40 0"
          "$mainMod+Ctrl, K, resizeactive, 0 -40"
          "$mainMod+Ctrl, J, resizeactive, 0 40"

          "$mainMod+Alt, H, moveactive, -40 0"
          "$mainMod+Alt, L, moveactive, 40 0"
          "$mainMod+Alt, K, moveactive, 0 -40"
          "$mainMod+Alt, J, moveactive, 0 40"

          "$mainMod+Shift, H, movewindow, l"
          "$mainMod+Shift, L, movewindow, r"
          "$mainMod+Shift, K, movewindow, u"
          "$mainMod+Shift, J, movewindow, d"

          "$mainMod, Tab, changegroupactive, f"

          "$mainMod+Shift, minus, movetoworkspacesilent, special"
          "$mainMod, minus, togglespecialworkspace,"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        ];
      };
    };
  };
}
