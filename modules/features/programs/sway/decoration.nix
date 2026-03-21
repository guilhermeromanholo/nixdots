{
  flake.modules.homeManager.sway = {
    # Sway Decoration
    wayland.windowManager.sway = {
      config = {
        # Window Gaps
        gaps = {
          inner = 6;
          outer = 4;
        };
      };

      # SwayFX Config
      extraConfig = ''
        # Window
        default_border pixel
        corner_radius 10

        # Blur
        blur enable
        blur_passes 4
        blur_radius 2
      '';
    };
  };
}
