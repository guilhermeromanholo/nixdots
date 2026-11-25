{ self, ... }:
{
  flake.wrappers.noctalia =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.noctalia
        self.lib.mkThemeOption
      ];

      colors = (import ./_palette.nix { inherit (config) theme; });

      settings = (
        import ./_settings.nix {
          inherit pkgs;
          inherit (config) theme;
        }
      );
    };
}
