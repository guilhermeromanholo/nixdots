{ self, lib, ... }:
{
  options.themes = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };

  config.themes = {
    gruvbox = {
      name = "gruvbox";
      colors = {
        base00 = "#282828";
        base01 = "#3c3836";
        base02 = "#504945";
        base03 = "#665c54";
        base04 = "#bdae93";
        base05 = "#d5c4a1";
        base06 = "#ebdbb2";
        base07 = "#fbf1c7";
        base08 = "#fb4934";
        base09 = "#fe8019";
        base0A = "#fabd2f";
        base0B = "#b8bb26";
        base0C = "#8ec07c";
        base0D = "#83a598";
        base0E = "#d3869b";
        base0F = "#d65d0e";
      };
      cursor = {
        size = 10;
        name = "Capitaine-Cursors-Gruvbox";
        package = "capitaine-cursors-themed";
      };
      icons = {
        name = "Gruvbox-Plus-Dark";
        package = "gruvbox-plus-icons";
      };
      gtk = {
        name = "Gruvbox-Dark";
        package = "gruvbox-gtk-theme";
      };
      wallpaper = (self + assets/gruvbox.png);
    };

    nord = {
      name = "nord";
      colors = {
        base00 = "#2E3440";
        base01 = "#3B4252";
        base02 = "#434C5E";
        base03 = "#4C566A";
        base04 = "#D8DEE9";
        base05 = "#E5E9F0";
        base06 = "#ECEFF4";
        base07 = "#8FBCBB";
        base08 = "#BF616A";
        base09 = "#D08770";
        base0A = "#EBCB8B";
        base0B = "#A3BE8C";
        base0C = "#88C0D0";
        base0D = "#81A1C1";
        base0E = "#B48EAD";
        base0F = "#5E81AC";
      };
      cursor = {
        size = 10;
        name = "Capitaine-Cursors-Nord";
        package = "capitaine-cursors-themed";
      };
      icons = {
        name = "Nordzy-cyan-dark";
        package = "nordzy-icon-theme";
      };
      gtk = {
        name = "Nordic";
        package = "nordic";
      };
      wallpaper = (self + assets/nord.jpg);
    };
  };
}
