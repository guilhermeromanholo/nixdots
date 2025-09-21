{pkgs, ...}: {
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
  };

  programs.xwayland.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
