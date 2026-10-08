{ inputs, lib, ... }: {
  perSystem = { pkgs, ... }: {
    packages.noctalia = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.noctalia;

      constructFiles = {
        settings = {
          relPath = "noctalia/config.toml";
          content = builtins.toJSON (
            import ./_settings.nix {
              inherit pkgs;
              inherit (inputs.self) theme;
            }
          );
          builder = "${lib.getExe pkgs.remarshal} -f json -i \"$1\" -t toml -o \"$2\"";
        };

        pallete = {
          relPath = "noctalia/palettes/palette.json";
          content = builtins.toJSON (import ./_palette.nix { inherit (inputs.self) theme; });
        };
      };

      env.NOCTALIA_CONFIG_HOME = "${placeholder "out"}/";
    };
  };
}
