{lib, ...}: {
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

    settings = lib.importTOML ./settings.toml;
    languages = lib.importTOML ./languages.toml;
  };
}
