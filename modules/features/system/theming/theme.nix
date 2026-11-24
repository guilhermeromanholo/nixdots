{ lib, ... }:
let
  namedPackage = lib.types.submodule {
    options = {
      name = lib.mkOption { type = lib.types.str; };
      package = lib.mkOption { type = lib.types.package; };
    };
  };
in
{
  flake.genericModules.theme = {
    options.theme = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption { type = lib.types.str; };
          colors = lib.mkOption { type = lib.types.attrs; };

          wallpaper = {
            default = lib.mkOption { type = lib.types.path; };
            directory = lib.mkOption { type = lib.types.path; };
          };

          gtk = lib.mkOption { type = namedPackage; };
          icons = lib.mkOption { type = namedPackage; };
          cursor = lib.mkOption { type = namedPackage; };

          fonts = {
            size = lib.mkOption { type = lib.types.int; };
            sans = lib.mkOption { type = namedPackage; };
            serif = lib.mkOption { type = namedPackage; };
            monospace = lib.mkOption { type = namedPackage; };
          };
        };
      };
    };
  };
}
