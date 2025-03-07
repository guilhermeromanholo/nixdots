{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.kitty;
in {
  options.modules.programs.kitty = {
    enable = lib.mkEnableOption "Kitty";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      shellIntegration.enableZshIntegration = true;

      settings = {
        enable_audio_bell = false;
        allow_hyperlinks = true;
      };
    };
  };
}
