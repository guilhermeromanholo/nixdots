{ lib, ... }:
{
  flake.nixosModules.theme =
    { pkgs, config, ... }:
    let
      t = config.settings.theme;

      gtkConfig = ''
        [Settings]
        gtk-theme-name=${t.gtk.name}
        gtk-icon-theme-name=${t.icons.name}
        gtk-font-name=${t.fonts.sans.name} ${toString t.fonts.size}
        gtk-cursor-theme-name=${t.cursor.name}
        gtk-cursor-theme-size=24
        gtk-application-prefer-dark-theme=1
      '';
    in
    {
      environment.systemPackages = [
        pkgs.${t.gtk.package}
        pkgs.${t.icons.package}
        pkgs.${t.cursor.package}
      ];

      environment.sessionVariables = {
        GTK_THEME = t.gtk.name;
        XCURSOR_SIZE = toString 24;
        XCURSOR_THEME = t.cursor.name;
      };

      environment.etc = {
        "xdg/gtk-3.0/settings.ini".text = gtkConfig;
        "xdg/gtk-4.0/settings.ini".text = gtkConfig;
      };

      programs.dconf = {
        enable = true;
        profiles.user.databases = [
          {
            settings."org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              gtk-theme = t.gtk.name;
              icon-theme = t.icons.name;
              cursor-theme = t.cursor.name;
              cursor-size = lib.gvariant.mkInt32 24;
              font-name = "${t.fonts.sans.name} ${toString t.fonts.size}";
            };
          }
        ];
      };
    };
}
