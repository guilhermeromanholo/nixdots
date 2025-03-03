{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.sessions.sway;
in {
  options.modules.sessions.sway = {
    enable = lib.mkEnableOption "Sway";
  };

  config = lib.mkIf cfg.enable {
    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
    };

    programs.xwayland.enable = true;

    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;

    services.dbus.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
