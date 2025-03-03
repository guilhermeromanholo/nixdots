{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.localtime;
in {
  options.modules.system.localtime = {
    enable = lib.mkEnableOption "Localtime";

    keymap = lib.mkOption {
      type = lib.types.str;
      default = "br-abnt2";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      default = "pt_BR.UTF-8";
    };

    timezone = lib.mkOption {
      type = lib.types.str;
      default = "America/Sao_Paulo";
    };
  };

  config = lib.mkIf cfg.enable {
    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;
    time.hardwareClockInLocalTime = true;

    i18n.extraLocaleSettings = {
      LANGUAGE = cfg.locale;
      LC_ALL = cfg.locale;
      LC_ADDRESS = cfg.locale;
      LC_IDENTIFICATION = cfg.locale;
      LC_MEASUREMENT = cfg.locale;
      LC_MONETARY = cfg.locale;
      LC_NAME = cfg.locale;
      LC_NUMERIC = cfg.locale;
      LC_PAPER = cfg.locale;
      LC_TELEPHONE = cfg.locale;
      LC_TIME = cfg.locale;
    };

    console.keyMap = cfg.keymap;
  };
}
