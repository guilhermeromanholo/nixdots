{ self, lib, ... }:
{
  flake.wrappers.kitty =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.kitty
        self.lib.mkThemeOption
      ];

      options.shellPackage = lib.mkOption {
        type = lib.types.package;
        default = pkgs.zsh;
        description = "Shell launched by Kitty.";
      };

      config.settings =
        import ./_settings.nix
        // import ./_palette.nix { inherit (config) theme; }
        // {
          shell = lib.getExe config.shellPackage;
          font_family = config.theme.fonts.monospace.name;
          font_size = config.theme.fonts.size;
        };
    };
}
