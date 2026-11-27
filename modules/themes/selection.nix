{ self, lib, ... }:
{
  options.flake.defaultTheme = lib.mkOption {
    type = self.lib.types.themeType;
    default = self.themes.gruvbox;
    description = "Default theme for NixOS and standalone wrappers.";
  };

  config.flake = {
    lib.types.effectiveThemeType = lib.types.submodule {
      imports = self.lib.types.themeType.getSubModules;
      config = lib.mapAttrsRecursive (_: lib.mkDefault) self.defaultTheme;
    };

    lib.wrapperModules.theme = {
      key = "nixdots:wrapperModules:theme";
      options.theme = lib.mkOption {
        type = self.lib.types.effectiveThemeType;
        default = { };
        description = "Effective theme used by this wrapper.";
      };
    };

    nixosModules.theme-options.key = "nixdots:modules/theme/selection.nix:theme-options";

    nixosModules.theme-options.options.settings.theme = lib.mkOption {
      type = self.lib.types.effectiveThemeType;
      default = { };
      description = "Effective theme shared by the system and its wrappers.";
    };
  };
}
