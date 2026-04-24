{
  flake.modules.homeManager.niri = {
    programs.niri.settings.layout = {
      gaps = 8;

      center-focused-column = "on-overflow";
      always-center-single-column = true;

      preset-column-widths = [
        {proportion = 1. / 2.;}
        {proportion = 2. / 3.;}
        {proportion = 1.;}
      ];
    };
  };
}
