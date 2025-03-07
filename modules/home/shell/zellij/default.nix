{
  lib,
  config,
  ...
}: let
  cfg = config.modules.shell.zellij;
in {
  options.modules.shell.zellij = {
    enable = lib.mkEnableOption "Zellij";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
