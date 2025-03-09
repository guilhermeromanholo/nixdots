{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.sway.waybar;
in {
  options.modules.desktop.sway.waybar = {
    enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
        target = "sway-session.target";
      };

      settings = {
        mainBar = {
          modules-left = [
            "custom/logo"
            "sway/workspaces"
            "tray"
          ];

          modules-center = [
            "temperature#icon"
            "temperature"

            "cpu#icon"
            "cpu"

            "memory#icon"
            "memory"

            "disk#icon"
            "disk"
          ];

          modules-right = [
            "pulseaudio#icon"
            "pulseaudio"

            "backlight#icon"
            "backlight"

            "battery#icon"
            "battery"

            "bluetooth#icon"
            "bluetooth"

            "network#icon"
            "network"

            "clock#icon"
            "clock"

            "custom/power"
          ];
        };

        # POWER
        "custom/power" = {
          format = " {icon} ";
          format-icons = "⏻";
          tooltip = false;
        };

        # PULSEAUDIO
        "pulseaudio#icon" = {
          format = "{icon}";
          format-bluetooth = "{icon}";
          format-muted = "{icon}";
          format-icons = "";
        };

        "pulseaudio" = {
          format = "{volume}%";
          format-bluetooth = "{volume}%";
          format-muted = "";
          scroll-step = 1;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        # TEMPERATURE
        "temperature#icon" = {
          format-critical = "";
          format = "{icon}";
          format-icons = ["" "" "" ""];
        };

        "temperature" = {
          interval = 10;
          critical-threshold = 80;
          format-critical = "{temperatureC}°C";
          format = "{temperatureC}°C";
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        };

        # TRAY
        "tray" = {
          spacing = 5;
        };

        # WORKSPACES
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };

        # NETWORK
        "network#icon" = {
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          format-disconnected = "";
          format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
        };

        "network" = {
          interval = 10;
          format-wifi = "{essid}";
          format-ethernet = "eth";
          format-disconnected = "Disconneted";
          tooltip-format = "{ifname}";
        };

        # MEMORY
        "memory#icon" = {
          format = "{icon}";
          format-icons = "";
        };

        "memory" = {
          interval = 10;
          format = "{used:0.1f}G";
          tooltip-format = "{percentage}% used";
        };

        # LOGO
        "custom/logo" = {
          format = " {icon} ";
          format-icons = "";
          tooltip = false;
        };

        # DISK
        "disk#icon" = {
          format = "󰋊";
        };

        "disk" = {
          interval = 10;
          format = "{percentage_used}%";
          tooltip-format = "{used} used out of {total}";
        };

        # CPU
        "cpu#icon" = {
          format = "{icon}";
          format-icons = "";
        };

        "cpu" = {
          interval = 10;
          format = "{usage}%";
        };

        # CLOCK
        "clock#icon" = {
          format = "";
          format-alt = "";
        };

        "clock" = {
          interval = 60;
          format = "{:%H:%M}";
          format-alt = "{:%b %d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        # BLUETOOTH
        "bluetooth#icon" = {
          format = "";
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
        };

        "bluetooth" = {
          format = "";
          format-on = "on";
          format-off = "off";
          format-disabled = "disb";
          format-connected = "conn";
          on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
        };

        # BACKLIGHT
        "backlight#icon" = {
          format = "{icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };

        "backlight" = {
          format = "{percent}%";
        };

        # BATTERY
        "battery#icon" = {
          format = "{icon}";
          format-charging = "{icon}";
          format-warning = "{icon}";
          format-critical = "{icon}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󱟢"];
          states = {
            warning = 30;
            critical = 15;
          };
        };

        "battery" = {
          format = "{capacity}%";
          format-charging = "{capacity}%";
          format-warning = "{capacity}%";
          format-critical = "{capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };
      };
    };
  };
}
