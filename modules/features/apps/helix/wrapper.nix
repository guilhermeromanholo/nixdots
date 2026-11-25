{ self, ... }:
{
  flake.wrappers.helix =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.helix
        self.lib.mkThemeOption
      ];

      runtimePkgs = with pkgs; [
        ty
        nixd
      ];

      settings = import ./_settings.nix {
        inherit (config) theme;
      };

      languages = import ./_languages.nix;
    };
}
