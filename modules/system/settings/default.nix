{
  flake.modules.nixos.settings = {
    config,
    lib,
    ...
  }: {
    options.settings = {
      # Network
      hostname = lib.mkOption {
        default = "nixos";
        type = lib.types.str;
      };

      # Locale
      locale = lib.mkOption {
        default = "pt_BR.UTF-8";
        type = lib.types.str;
      };

      timezone = lib.mkOption {
        default = "America/Sao_Paulo";
        type = lib.types.str;
      };

      # Boot
      uefi = lib.mkEnableOption "Enable uefi";
      osProber = lib.mkEnableOption "Enable osProber";

      bootDevice = lib.mkOption {
        default = "nodev";
        type = lib.types.str;
      };
    };
  };
}
