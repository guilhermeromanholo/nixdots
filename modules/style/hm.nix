{
  outputs,
  lib,
  config,
  options,
  pkgs,
  ...
}: let
  cfg = config.modules.style;
in {
  options.modules.style = {
    enable = lib.mkEnableOption "Style";

    theme = lib.mkOption {
      type = lib.types.attrs;
      default = outputs.themes.gruvbox;
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    (import ./stylix {
      inherit pkgs;
      inherit (cfg) theme;
    })

    (import ./icons {
      inherit pkgs;
      inherit (cfg) theme;
    })

    (import ./gnome-shell {
      inherit lib pkgs;
      inherit (cfg) theme;
    })

    (import ./hyprpanel {
      inherit lib options;
      inherit (cfg) theme;
    })
  ]);
}
