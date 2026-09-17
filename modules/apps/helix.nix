{
  inputs,
  self,
  lib,
  ...
}: {
  flake.modules.nixos.helix = {
    self',
    config,
    ...
  }: {
    imports = with self.modules.nixos; [
      theming
    ];

    environment.systemPackages = [
      (self'.packages.helix.wrap {
        settings.theme = "custom";
        themes.custom = lib.importTOML (self.lib.applyTheme config "helix");
      })
    ];
  };

  flake.wrappers.helix = {
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.wrapperModules.helix];

    runtimePkgs = with pkgs; [
      ty
      nixd
    ];

    settings = lib.importTOML "${inputs.dots}/helix/config.toml";
    languages = lib.importTOML "${inputs.dots}/helix/languages.toml";
  };
}
