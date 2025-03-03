{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.system.users;
in {
  options.modules.system.users = lib.mkOption {
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

  config = lib.mkIf (cfg != {}) {
    users.users =
      lib.mapAttrs (_: value: {
        isNormalUser = true;
        extraGroups = value.groups;

        shell = pkgs.${value.shell};
        ignoreShellProgramCheck = true;

        initialPassword = "password";
        openssh.authorizedKeys.keys = value.authKeys;
      })
      cfg;
  };
}
