{ self, ... }:
{
  flake.nixosModules.theme =
    { pkgs, config, ... }:
    let
      t = config.settings.theme;
      getPkg = self.lib.getThemePackage pkgs;
    in
    {
      key = "nixdots:modules/theme/nixos/fonts.nix:theme";
      fonts = {
        packages = [
          (getPkg t.fonts.sans.package)
          (getPkg t.fonts.serif.package)
          (getPkg t.fonts.monospace.package)
        ];

        fontconfig.defaultFonts = {
          serif = [ t.fonts.serif.name ];
          sansSerif = [ t.fonts.sans.name ];
          monospace = [ t.fonts.monospace.name ];
        };
      };
    };
}
