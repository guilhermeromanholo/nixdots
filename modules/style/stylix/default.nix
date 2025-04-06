{
  theme,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    image = theme.image;
    polarity = theme.polarity;
    base16Scheme = theme.colorscheme;

    cursor = {
      name = theme.cursor.name;
      package = pkgs.${theme.cursor.package};
      size = 15;
    };

    fonts = {
      monospace = {
        name = "FiraCode Nerd Font Mono";
        package = pkgs.nerd-fonts.fira-code;
      };

      sansSerif = {
        name = "Open Sans";
        package = pkgs.open-sans;
      };

      serif = {
        name = "Roboto Serif";
        package = pkgs.roboto-serif;
      };
    };

    opacity = {
      popups = 0.85;
      desktop = 0.85;
      terminal = 0.85;
      applications = 0.85;
    };
  };
}
