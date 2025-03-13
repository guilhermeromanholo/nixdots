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
          # "forge@jmmaranan.com"
          "blur-my-shell@aunetx"
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
      # gnomeExtensions.forge
      gnomeExtensions.user-themes
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell
      gnomeExtensions.tray-icons-reloaded
    ];
  };
}
