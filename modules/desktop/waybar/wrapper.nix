{ self, ... }:
{
  flake.wrappers.waybar =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.waybar
        self.lib.mkThemeOption
      ];
      settings = builtins.fromJSON (builtins.readFile ./_config/config.json);
      "style.css".path = pkgs.writeText "waybar.css" (
        import ./_palette.nix { inherit (config) theme; } + builtins.readFile ./_config/style.css
      );
    };
}
