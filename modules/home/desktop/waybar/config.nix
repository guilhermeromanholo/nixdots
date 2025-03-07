{
  programs.waybar = {
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
    };
  };
}
