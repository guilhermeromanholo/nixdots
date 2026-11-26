{
  flake.nixosModules.greeter = { config, ... }: {
    key = "nixdots:modules/desktop/greeter/default.nix:greeter";
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings.appearance = {
        scheme = "Synced";
        hide_logo = true;
        palette = import ./_palette.nix { theme = config.settings.theme; };
        wallpaper = {
          fill_mode = "fit";
          path = config.settings.theme.wallpaper.default;
        };
      };
    };
  };
}
