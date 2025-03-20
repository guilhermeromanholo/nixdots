{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.hyprland.hyprpanel;
in {
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
  ];

  options.modules.desktop.hyprland.hyprpanel = {
    enable = lib.mkEnableOption "Hyprpanel";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox";
    };

    scaling = lib.mkOption {
      type = lib.types.int;
      default = 85;
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
            left = ["dashboard" "workspaces" "cpu" "ram" "systray"];
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
          dashboard = {
            stats.enabled = false;
            directories.enabled = false;
            shortcuts.left.shortcut4.command = "${pkgs.wofi}/bin/wofi";
          };

          clock.time.military = true;
          clock.weather.enabled = false;
        };

        theme = {
          font = {
            size = "1.0rem";
            weight = 600;
          };

          bar = {
            scaling = cfg.scaling;
            floating = true;

            menus.menu = {
              media.scaling = cfg.scaling;
              clock.scaling = cfg.scaling;
              dashboard.scaling = cfg.scaling;
              notifications.scaling = cfg.scaling;
            };
          };
        };
      };
    };
  };
}
