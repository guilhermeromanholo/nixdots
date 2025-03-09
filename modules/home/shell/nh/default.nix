{
  lib,
  config,
  ...
}: let
  cfg = config.modules.shell.nh;
in {
  options.modules.shell.nh = {
    enable = lib.mkEnableOption "Nh";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/.nixdots";
    };
  };
}
