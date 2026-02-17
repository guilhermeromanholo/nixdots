{self, ...}: {
  flake.modules.nixos.sway = {
    lib,
    pkgs,
    config,
    ...
  }: {
    home-manager.sharedModules = [
      self.modules.homeManager.sway
    ];

    programs.sway = {
      enable = true;
      package = pkgs.swayfx;

      extraPackages = [];
      wrapperFeatures.gtk = true;
    };

    programs.xwayland.enable = true;

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
