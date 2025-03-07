{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.shell.git;
in {
  options.modules.shell.git = {
    enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      git
    ];
  };
}
