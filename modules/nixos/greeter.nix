{self, ...}: {
  flake.modules.nixos.greeter = {
    services.displayManager.noctalia-greeter = {
      enable = true;

      settings.appearance = {
        scheme = "Synced";
        hide_logo = true;

        palette = with self.theme.scheme; {
          error = "#${base08}";
          hover = "#${base02}";
          shadow = "#${base00}";
          primary = "#${base0D}";
          surface = "#${base00}";
          outline = "#${base03}";
          tertiary = "#${base0E}";
          on_error = "#${base00}";
          on_hover = "#${base05}";
          secondary = "#${base0C}";
          on_primary = "#${base00}";
          on_surface = "#${base05}";
          on_tertiary = "#${base00}";
          on_secondary = "#${base00}";
          surface_variant = "#${base01}";
          on_surface_variant = "#${base04}";
        };

        wallpaper = {
          fill_mode = "fit";
          path = self.theme.wallpaper;
        };
      };
    };
  };
}
