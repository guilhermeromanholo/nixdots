{lib, ...}: {
  options.modules.impermanence = {
    enable = lib.mkEnableOption "Impermanence";

    persistPath = lib.mkOption {
      type = lib.types.str;
      default = "/persist";
    };

    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };

    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
