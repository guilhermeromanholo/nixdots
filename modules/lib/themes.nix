{ self, lib, ... }:
{
  options.flake.themes = lib.mkOption {
    type = lib.types.attrsOf self.lib.types.themeType;
    default = { };
  };

  config.flake.lib = rec {
    readTheme = dir: file: fromTOML (builtins.readFile (dir + "/${file}"));

    mkTheme =
      { themes, wallpapers }:
      file:
      let
        name = lib.removeSuffix ".toml" file;
      in
      lib.recursiveUpdate (readTheme themes file) {
        inherit name;
        wallpaper = {
          default = wallpapers + "/${name}/default.png";
          directory = wallpapers + "/${name}";
        };
      };

    importThemes =
      dirs:
      lib.mapAttrs' (file: _: lib.nameValuePair (lib.removeSuffix ".toml" file) (mkTheme dirs file)) (
        builtins.readDir dirs.themes
      );

    mkThemeOption = {
      options.theme = lib.mkOption {
        type = self.lib.types.themeType;
        default = self.themes.gruvbox;
      };
    };
  };

  config.flake.themes = self.lib.importThemes {
    themes = (self + "/assets/schemes");
    wallpapers = (self + "/assets/wallpapers");
  };
}
