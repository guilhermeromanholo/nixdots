{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.sessions.gnome;
in {
  options.modules.sessions.gnome = {
    enable = lib.mkEnableOption "Gnome";
  };

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;

    services.xserver.desktopManager.gnome.enable = true;
    environment.systemPackages = [pkgs.gnome-tweaks];

    environment.gnome.excludePackages = with pkgs; [
      cheese
      gnome-tour
      gnome-photos
      gnome-console
      gnome-music
      gedit
      epiphany
      geary
      gnome-characters
      tali
      iagno
      hitori
      atomix
      yelp
      gnome-contacts
      gnome-initial-setup
    ];
  };
}
