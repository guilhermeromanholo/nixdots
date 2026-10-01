{
  inputs,
  lib,
  ...
}: {
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

    settings = lib.importTOML ./config/config.toml;
    languages = lib.importTOML ./config/languages.toml;
    themes.custom = lib.importTOML (inputs.self.lib.applyTheme ./config/base16.mustache pkgs);
  };
}
