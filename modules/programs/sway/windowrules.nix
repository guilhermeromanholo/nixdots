{
  flake.modules.homeManager.sway = {
    wayland.windowManager.sway = {
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

        # SwayFX
        corner_radius 10
        blur enable
        blur_passes 4
        blur_radius 2
      '';
    };
  };
}
