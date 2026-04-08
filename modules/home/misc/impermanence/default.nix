{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.misc.impermanence;
in {
  options.modules.misc.impermanence = {
    enable = lib.mkEnableOption "Impermanence";

    path = lib.mkOption {
      type = lib.types.str;
      default = "/persist";
    };

    dirs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };

    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    home.persistence."${cfg.path}${config.home.homeDirectory}" = {
      allowOther = true;
      files = cfg.files;
      directories = cfg.dirs;
    };
  };
}
