{ self, lib, ... }:
{
  flake.wrappers.noctalia =
    {
      wlib,
      pkgs,
      config,
      ...
    }:
    {
      imports = [
        wlib.modules.default
        self.lib.wrapperModules.theme
      ];

      options = {
        settings = lib.mkOption {
          type = wlib.types.structuredValueWith { typeName = "TOML"; };
          default = { };
          description = "Noctalia settings, converted to TOML at build time.";
        };
        colors = lib.mkOption {
          type = wlib.types.structuredValueWith { typeName = "JSON"; };
          default = { };
          description = "Noctalia custom palette.";
        };
      };

      config = {
        package = pkgs.noctalia;
        settings = import ./_settings.nix {
          inherit pkgs;
          inherit (config) theme;
        };
        colors = import ./_palette.nix { inherit (config) theme; };
        env.NOCTALIA_CONFIG_HOME = placeholder config.outputName;
        passthru.generatedConfig = "${config.wrapper}/noctalia";
        meta.platforms = lib.platforms.linux;

        # Avoid the upstream wrapper's import from derivation when generating TOML.
        constructFiles = {
          settings = {
            relPath = "noctalia/settings.toml";
            content = builtins.toJSON config.settings;
            builder = ''${pkgs.remarshal}/bin/json2toml "$1" "$2"'';
          };
          colors = {
            relPath = "noctalia/palettes/custom.json";
            content = builtins.toJSON config.colors;
          };
        };
      };
    };
}
