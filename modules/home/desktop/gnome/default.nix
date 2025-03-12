{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.desktop.gnome;
in {
  options.modules.desktop.gnome = {
    enable = lib.mkEnableOption "Gnome";
  };

  config = lib.mkIf cfg.enable {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "trayIconsReloaded@selfmade.pl"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];

        favorite-apps = [
          "firefox.desktop"
          "kitty.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };
    };

    home.packages = with pkgs; [
      gnomeExtensions.user-themes
      gnomeExtensions.dash-to-dock
      gnomeExtensions.tray-icons-reloaded
    ];
  };
}
