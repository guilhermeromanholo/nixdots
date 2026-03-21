{self, ...}: {
  flake.modules.nixos.sway = {
    # Enable Sway
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    # OpenGL
    hardware.graphics.enable = true;

    # Security
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # Screen Sharing
    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    # Home-Manager
    home-manager.sharedModules = [
      self.modules.homeManager.sway
    ];
  };

  flake.modules.homeManager.sway = {pkgs, ...}: {
    # Enable Home-Manager config
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;

      checkConfig = false;
      wrapperFeatures.gtk = true;
    };
  };
}
