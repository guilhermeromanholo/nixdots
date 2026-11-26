{
  lib,
  self,
  pkgs,
}:
let
  theme = lib.recursiveUpdate self.themes.nord {
    name = "custom-nord";
    colors.base00 = "#112233";
    fonts.size = 21;
  };
  wrapped = name: self.wrappers.${name}.apply { inherit pkgs theme; };
  normalize =
    themeValue:
    (lib.evalModules {
      modules = [
        self.lib.mkThemeOption
        { theme = themeValue; }
      ];
    }).config.theme;
in
lib.runTests {
  testKittyUsesEffectiveTheme = {
    expr = {
      background = (wrapped "kitty").settings.background;
      size = (wrapped "kitty").settings.font_size;
    };
    expected = {
      background = "#112233";
      size = 21;
    };
  };
  testHelixUsesGeneratedPalette = {
    expr = {
      selected = (wrapped "helix").settings.theme;
      background = (wrapped "helix").themes.custom.palette.base00;
    };
    expected = {
      selected = "custom";
      background = "#112233";
    };
  };
  testStarshipUsesEffectiveTheme = {
    expr = {
      selected = (wrapped "starship").settings.palette;
      blue = (wrapped "starship").settings.palettes.custom.color_blue;
    };
    expected = {
      selected = "custom";
      blue = self.themes.nord.colors.base0D;
    };
  };
  testNoctaliaUsesEffectiveTheme = {
    expr = (wrapped "noctalia").colors.dark.mSurface;
    expected = "#112233";
  };
  testUnknownThemeNameWorksInOverlay = {
    expr = ((self.lib.mkOverlay { inherit theme; } pkgs pkgs).my.kitty.apply { }).settings.background;
    expected = "#112233";
  };
  testInvalidColorRejected = {
    expr =
      (builtins.tryEval (
        builtins.deepSeq (normalize (
          lib.recursiveUpdate self.themes.nord { colors.base00 = "invalid"; }
        )) true
      )).success;
    expected = false;
  };
  testBothThemesNormalize = {
    expr = map (name: (normalize self.themes.${name}).name) [
      "gruvbox"
      "nord"
    ];
    expected = [
      "gruvbox"
      "nord"
    ];
  };
  testPartialOverrideKeepsDefaults = {
    expr =
      let
        selected = normalize { fonts.size = 23; };
      in
      {
        size = selected.fonts.size;
        name = selected.name;
        background = selected.colors.base00;
      };
    expected = {
      size = 23;
      name = self.defaultTheme.name;
      background = self.defaultTheme.colors.base00;
    };
  };

}
