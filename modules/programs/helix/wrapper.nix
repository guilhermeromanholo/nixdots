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
      settings = import ./_settings.nix;
      languages = import ./_languages.nix;
      themes.custom = import ./_palette.nix { inherit (config) theme; };
    };
}
