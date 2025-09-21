let
  cfg = config.modules.gnome;
in {
  imports = [./options.nix];

  # X11
  services.xserver = {
    enable = true;

    xkb.layout = cfg.xkb.layout;
    xkb.variant = cfg.xkb.variant;
  };

  # Gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
