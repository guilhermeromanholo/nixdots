{ self, ... }: {
  flake.wrappers.starship =
    {
      config,
      wlib,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.starship
        self.modules.generic.wrapper-theme
      ];
      settings = {
        palette = "nixdots";
        palettes.nixdots = {
          blue = config.theme.semantic.accent;
          red = config.theme.semantic.error;
          green = config.theme.semantic.success;
          yellow = config.theme.semantic.warning;
          purple = config.theme.colors.base0E;
        };
        directory.style = "bold blue";
        character.success_symbol = "[❯](bold green)";
        character.error_symbol = "[❯](bold red)";
      };
    };
}
