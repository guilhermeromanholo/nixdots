{ lib, ... }: {
  den.aspects.gtk.nixos =
    { host, pkgs, ... }:
    let
      t = host.theme;
      gtkConfig = ''
        [Settings]
        gtk-theme-name=${t.gtk.name}
        gtk-icon-theme-name=${t.icons.name}
        gtk-font-name=Open Sans 12
        gtk-cursor-theme-name=${t.cursor.name}
        gtk-cursor-theme-size=${toString t.cursor.size}
        gtk-application-prefer-dark-theme=1
      '';
    in
    {
      fonts = {
        packages = with pkgs; [
          open-sans
          roboto-serif
          nerd-fonts.fira-code
        ];

        fontconfig.defaultFonts = {
          serif = [ "Roboto Serif" ];
          sansSerif = [ "Open Sans" ];
          monospace = [ "FiraCode Nerd Font Mono" ];
        };
      };

      environment.systemPackages = [
        pkgs.${t.gtk.package}
        pkgs.${t.icons.package}
        pkgs.${t.cursor.package}
      ];

      environment.sessionVariables = {
        GTK_THEME = t.gtk.name;
        XCURSOR_THEME = t.cursor.name;
        XCURSOR_SIZE = toString t.cursor.size;
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
              cursor-size = lib.gvariant.mkInt32 t.cursor.size;
              font-name = "Open Sans 12";
            };
          }
        ];
      };

      qt = {
        enable = true;
        platformTheme = "gnome";
        style = "adwaita-dark";
      };
    };
}
