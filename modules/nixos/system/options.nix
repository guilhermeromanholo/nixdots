{lib, ...}: {
  options.modules.system = {
    # Boot
    uefi = lib.mkEnableOption "Enable boot uefi";
    os-prober = lib.mkEnableOption "Enable os-prober";

    grubDevice = lib.mkOption {
      type = lib.types.str;
      default = "nodev";
    };

    # Network
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };

    # Localtime
    timezone = lib.mkOption {
      type = lib.types.str;
      default = "America/Sao_Paulo";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      default = "pt_BR.UTF-8";
    };

    keymap = lib.mkOption {
      type = lib.types.str;
      default = "br-abnt2";
    };

    # Users
    users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          shell = lib.mkOption {
            type = lib.types.str;
            default = "fish";
            description = "Shell";
          };

          groups = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "Groups";
          };

          authKeys = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "SSH Keys";
          };
        };
      });
    };

    # Version
    stateVersion = lib.mkOption {
      type = lib.types.str;
    };
  };
}
