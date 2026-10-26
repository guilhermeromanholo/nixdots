{ self, ... }: {
  imports = [
    ./gruvbox.nix
    ./nord.nix
  ];

  flake.modules.nixos.theme =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      t = config.nixdots.theme;
      gtkConfig = ''
        [Settings]
        gtk-theme-name=${t.gtk.name}
        gtk-icon-theme-name=${t.icons.name}
        gtk-font-name=${t.fonts.sans} ${toString t.fonts.size}
        gtk-cursor-theme-name=${t.cursor.name}
        gtk-cursor-theme-size=${toString t.cursor.size}
        gtk-application-prefer-dark-theme=1
      '';
    in
    {
      imports = [ self.modules.nixos.theme-contract ];
      fonts = {
        packages = with pkgs; [
          nerd-fonts.fira-code
          open-sans
          roboto-serif
        ];
        fontconfig.defaultFonts = {
          monospace = [ t.fonts.monospace ];
          sansSerif = [ t.fonts.sans ];
          serif = [ t.fonts.serif ];
        };
      };
      environment.systemPackages = [
        pkgs.${t.cursor.package}
        pkgs.${t.icons.package}
        pkgs.${t.gtk.package}
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
              font-name = "${t.fonts.sans} ${toString t.fonts.size}";
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
