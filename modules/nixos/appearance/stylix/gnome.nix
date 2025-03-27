{
  theme,
  lib,
  pkgs,
  ...
}: {
  dconf.settings."org/gnome/shell/extensions/user-theme" = {
    name = lib.mkForce (theme.gnome-shell.name);
  };

  home.packages = [
    pkgs.${theme.gnome-shell.package}
  ];
}
