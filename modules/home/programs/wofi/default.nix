{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.wofi;
in {
  options.modules.programs.wofi = {
    enable = lib.mkEnableOption "Wofi";
  };

  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;

      settings = {
        show = "drun";
        width = "30%";
        height = "50%";
        location = 0;
        prompt = "Search";
        no_actions = true;
        insensitive = true;
        allow_images = true;
        normal_window = true;
      };
    };
  };
}
