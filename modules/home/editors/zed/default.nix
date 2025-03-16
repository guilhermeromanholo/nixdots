{
  lib,
  config,
  ...
}: let
  cfg = config.modules.editors.zed;
in {
  options.modules.editors.zed = {
    enable = lib.mkEnableOption "Zed";
  };

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;

      userSettings = {
        vim_mode = true;

        formatter = {
          language_server.name = "biome";
        };
      };

      extensions = [
        "nix"
        "pylsp"
      ];
    };
  };
}
