{
  flake.modules.homeManager.niri = {
    programs.niri.settings.layout = {
      gaps = 12;

      center-focused-column = "never";
      always-center-single-column = true;

      default-column-width = { proportion = 0.50; };

      preset-column-widths = [
        {proportion = 1. / 3.;}
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
      ];

      preset-window-heights = [
        {proportion = 1. / 3.;}
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
      ];
    };
  };
}
