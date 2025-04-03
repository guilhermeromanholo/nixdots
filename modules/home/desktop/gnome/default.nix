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
          "unblank@sun.wxg@gmail.com"
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

      "org/gnome/shell/extensions/unblank".time = 300;
    };

    home.packages = with pkgs; [
      # gnomeExtensions.forge
      gnomeExtensions.unblank
      gnomeExtensions.user-themes
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell
      gnomeExtensions.tray-icons-reloaded
    ];
  };
}
