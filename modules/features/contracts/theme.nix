{ lib, ... }:
{
  flake.modules.generic.theme = {
    options.theme = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "Theme identifier";
          };

          colors = lib.mkOption {
            type = lib.types.attrs;
            description = "Base16 in hexadecimal with #";
          };

          icons = {
            name = lib.mkOption { type = lib.types.name; };
            package = lib.mkOption { type = lib.types.package; };
          };

          cursor = {
            name = lib.mkOption { type = lib.types.name; };
            package = lib.mkOption { type = lib.types.package; };
          };

          fonts = {
            monospace = lib.mkOption {
              type = lib.types.str;
              default = "FiraCode Nerd Font Mono";
            };
            sans = lib.mkOption {
              type = lib.types.str;
              default = "Open Sans";
            };
            serif = lib.mkOption {
              type = lib.types.str;
              default = "Roboto Serif";
            };
          };

          wallpaper = {
            default = lib.mkOption { type = lib.types.path; };
            directory = lib.mkOption { type = lib.types.path; };
          };

          opacity = lib.mkOption {
            type = lib.types.numbers.between 0.0 1.0;
            default = 0.85;
          };
        };
      };
    };
  };
}
