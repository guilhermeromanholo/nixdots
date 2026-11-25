{ self, lib, ... }:
{
  flake.nixosModules.options = {
    options.settings = {
      user = {
        # User name
        name = lib.mkOption {
          default = "glhrm";
          type = lib.types.str;
        };
      };

      # System theme
      theme = lib.mkOption {
        type = self.lib.types.themeType;
        default = self.themes.gruvbox;
      };
    };
  };
}
