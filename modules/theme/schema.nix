{ lib, ... }:
let
  inherit (lib) mkOption types;
  namedPackage = types.submodule {
    options = {
      name = mkOption {
        type = types.nonEmptyStr;
        description = "Name understood by the application or fontconfig.";
      };
      package = mkOption {
        type = types.nonEmptyStr;
        description = "Dot-separated attribute path in nixpkgs.";
      };
    };
  };
  colorNames = map (suffix: "base${suffix}") [
    "00"
    "01"
    "02"
    "03"
    "04"
    "05"
    "06"
    "07"
    "08"
    "09"
    "0A"
    "0B"
    "0C"
    "0D"
    "0E"
    "0F"
  ];
in
{
  flake.lib.types.themeType = types.submodule {
    options = {
      name = mkOption {
        type = types.nonEmptyStr;
        description = "Theme identifier.";
      };
      colors = lib.genAttrs colorNames (
        name:
        mkOption {
          type = types.strMatching "#[0-9a-fA-F]{6}";
          description = "Base16 ${name} color, including the leading #.";
        }
      );
      wallpaper = {
        default = mkOption {
          type = types.path;
          description = "Default wallpaper.";
        };
        directory = mkOption {
          type = types.path;
          description = "Directory containing this theme's wallpapers.";
        };
      };
      fonts = {
        size = mkOption {
          type = types.ints.positive;
          default = 18;
          description = "Default UI font size.";
        };
        sans = mkOption {
          type = namedPackage;
          default = {
            name = "OpenSans";
            package = "open-sans";
          };
          description = "Default sans-serif font.";
        };
        serif = mkOption {
          type = namedPackage;
          default = {
            name = "Roboto Serif";
            package = "roboto-serif";
          };
          description = "Default serif font.";
        };
        monospace = mkOption {
          type = namedPackage;
          default = {
            name = "FiraCode Nerd Font Mono";
            package = "nerd-fonts.fira-code";
          };
          description = "Default monospace font.";
        };
      };
      gtk = mkOption {
        type = namedPackage;
        description = "GTK theme.";
      };
      icons = mkOption {
        type = namedPackage;
        description = "Icon theme.";
      };
      cursor = mkOption {
        type = namedPackage;
        description = "Cursor theme.";
      };
    };
  };

  flake.lib.getThemePackage = pkgs: path: lib.getAttrFromPath (lib.splitString "." path) pkgs;
}
