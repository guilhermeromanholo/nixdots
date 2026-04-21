{
  flake.modules.nixos.wayland = {pkgs, ...}: {
    programs.xwayland.enable = true;

    xdg.portal = {
      enable = true;

      extraPortals = [
	pkgs.xdg-desktop-portal-gnome
      ];
    };
  };
}
