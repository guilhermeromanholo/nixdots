{ inputs, lib, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.helix = inputs.wrappers.wrappers.helix.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        ty
        nixd
      ];

      settings = lib.mkMerge [
        { theme = inputs.self.theme.slug; }
        (lib.importTOML ./settings.toml)
      ];

      languages = lib.importTOML ./languages.toml;
    };
  };
}
