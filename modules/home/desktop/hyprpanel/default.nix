{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprpanel;
in {
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  options.modules.desktop.hyprpanel = {
    enable = lib.mkEnableOption "Hyprpanel";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprpanel = {
      enable = true;
      hyprland.enable = true;
      theme = "${cfg.theme}_split";

      layout = {
        "bar.layouts" = {
          "*" = {
            left = ["dashboard" "workspaces" "windowtitle" "systray"];
            middle = ["media"];
            right = ["volume" "network" "clock" "notifications"];
          };
        };
      };

      settings = {
        bar = {
          clock.format = "%H:%M, %d %b";
          launcher.autoDetectIcon = true;
        };

        menus = {
          dashboard.directories.enabled = false;
          dashboard.shortcuts.left.shortcut4.command = "${pkgs.wofi}/bin/wofi";
        };

        theme = {
          font.size = "1.0rem";
          font.weight = 600;
        };
      };
    };
  };
}
