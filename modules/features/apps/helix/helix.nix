{
  inputs,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: {
    packages.helix = inputs.wrappers.wrappers.helix.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        ty
        nixd
      ];

      settings = lib.mkMerge [
        (lib.importTOML ./settings.toml)
        {theme = inputs.self.theme.slug;}
      ];

      languages = lib.importTOML ./languages.toml;
    };
  };
}
