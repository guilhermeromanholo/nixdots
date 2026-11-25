{ lib, ... }:
{
  flake.lib.types = rec {
    # User to namedPackages like icons, gtk theme
    # cursors, etc ...
    namedPackage = lib.types.submodule {
      options = {
        name = lib.mkOption { type = lib.types.str; };
        package = lib.mkOption { type = lib.types.str; };
      };
    };

    # Theme type used for flake-parts,
    # wrappers and nixosModules
    themeType = lib.types.submodule {
      options = {
        name = lib.mkOption { type = lib.types.str; };
        colors = lib.mkOption { type = lib.types.attrs; };

        wallpaper = {
          default = lib.mkOption { type = lib.types.path; };
          directory = lib.mkOption { type = lib.types.path; };
        };

        fonts = {
          size = lib.mkOption {
            type = lib.types.int;
            default = 18;
          };

          sans = lib.mkOption {
            type = namedPackage;
            default = {
              name = "OpenSans";
              package = "open-sans";
            };
          };

          serif = lib.mkOption {
            type = namedPackage;
            default = {
              name = "Roboto Serif";
              package = "roboto-serif";
            };
          };

          monospace = lib.mkOption {
            type = namedPackage;
            default = {
              name = "FiraCode Nerd Font Mono";
              package = "nerd-fonts.fira-code";
            };
          };
        };

        gtk = lib.mkOption { type = namedPackage; };
        icons = lib.mkOption { type = namedPackage; };
        cursor = lib.mkOption { type = namedPackage; };
      };
    };
  };
}
