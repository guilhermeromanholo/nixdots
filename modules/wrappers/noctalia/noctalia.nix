{inputs, ...}: {
  flake.wrappers.noctalia = {
    wlib,
    pkgs,
    config,
    ...
  }: {
    imports = [wlib.modules.default];
    package = pkgs.noctalia;

    constructFiles."settings.toml" = {
      relPath = "noctalia/settings.toml";
      content = ''
               ${builtins.readFile ./config/settings.toml}

               [wallpaper.default]
               path = "${inputs.self.theme.wallpaper}"

        [widget.launcher]
        custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg"
      '';
    };

    constructFiles."custom.json" = {
      relPath = "noctalia/palettes/custom.json";
      content = builtins.readFile (
        inputs.self.lib.applyTheme ./config/base16.mustache pkgs
      );
    };

    env.NOCTALIA_CONFIG_HOME = "${placeholder config.outputName}";
  };
}
