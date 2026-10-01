{self, ...}: {
  flake.modules.nixos.greeter = {
    services.displayManager.noctalia-greeter = {
      enable = true;

      settings.appearance = {
	scheme = "Synced";
        hide_logo = true;

        wallpaper.path = self.theme.wallpaper;
	wallpaper.fill_mode = "fit";

        palette = with self.theme.scheme; {
          primary = "#${base0D}";
          on_primary = "#${base00}";
          secondary = "#${base0C}";
          on_secondary = "#${base00}";
          tertiary = "#${base0E}";
          on_tertiary = "#${base00}";
          error = "#${base08}";
          on_error = "#${base00}";
          surface = "#${base00}";
          on_surface = "#${base05}";
          surface_variant = "#${base01}";
          on_surface_variant = "#${base04}";
          outline = "#${base03}";
          shadow = "#${base00}";
          hover = "#${base02}";
          on_hover = "#${base05}";
        };
      };
    };
  };
}
