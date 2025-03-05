{lib, ...}: {
  options.modules.impermanence = {
    enable = lib.mkEnableOption "Impermanence";

    persistPath = lib.mkOption {
      type = lib.types.str;
      default = "/persist";
    };

    directories = lib.mkOption {
      type = with lib.types;
        oneOf [
          (listOf attrs)
          (listOf str)
        ];
      default = [];
    };

    files = lib.mkOption {
      type = with lib.types;
        oneOf [
          (listOf attrs)
          (listOf str)
        ];
      default = [];
    };
  };
}
