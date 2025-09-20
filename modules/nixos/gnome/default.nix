{
  imports = [./options.nix];

  # X11
  services.xserver = {
    enable = true;

    xkb.layout = "br";
    xkb.variant = "thinkpad";
  };

  # Gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
