{
  lib,
  config,
  ...
}: let
  cfg = config.modules.programs.foot;
in {
  options.modules.programs.foot = {
    enable = lib.mkEnableOption "Foot";
  };

  config = lib.mkIf cfg.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
    };
  };
}
