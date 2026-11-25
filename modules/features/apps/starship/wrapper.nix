{ self, ... }:
{
  flake.wrappers.starship = { wlib, ... }: {
    imports = [
      wlib.wrapperModules.starship
      self.lib.mkThemeOption
    ];

    preset = [ "gruvbox-rainbow" ];
  };
}
