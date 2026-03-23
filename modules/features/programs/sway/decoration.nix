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

      # Window Decoration
      extraConfig = ''
        # Window
        default_border pixel
      '';
    };
  };
}
