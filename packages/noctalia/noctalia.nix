{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.noctalia = inputs.wrappers.lib.wrapPackage ({config, ...}: {
      inherit pkgs;
      package = pkgs.noctalia;

      constructFiles."settings.toml" = {
        relPath = "noctalia/settings.toml";
        content = ''
          ${builtins.readFile ./config/settings.toml}

          [wallpaper.default]
          path = "${inputs.self.theme.wallpaper}"
        '';
      };

      constructFiles."custom.json" = {
        relPath = "noctalia/palettes/custom.json";
        content = builtins.readFile (
          inputs.self.lib.applyTheme ./config/base16.mustache pkgs
        );
      };

      env.NOCTALIA_CONFIG_HOME = "${placeholder config.outputName}";
    });
  };
}
