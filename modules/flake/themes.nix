{
  config,
  lib,
  ...
}: {
  options.themes = with lib;
    mkOption {
      type = types.lazyAttrsOf (types.submodule {
        options = {
          icon = mkOption {type = types.attrs;};
          cursor = mkOption {type = types.attrs;};
          colors = mkOption {type = types.attrs;};
          wallpaper = mkOption {type = types.str;};
        };
      });
    };

  config.flake.theme = config.flake.themes.gruvbox;
}
