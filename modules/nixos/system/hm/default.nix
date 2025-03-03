{
  inputs,
  outputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.hm;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.modules.system.hm = {
    enable = lib.mkEnableOption "Home Manager";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };

    modules = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [];
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      # Default configs
      useGlobalPkgs = true;
      useUserPackages = true;

      # Custom Home Manager
      # modules
      sharedModules =
        (
          if (outputs ? homeManagerModules)
          then lib.attrValues outputs.homeManagerModules
          else []
        )
        ++ cfg.modules;

      # User config
      users = lib.listToAttrs (map (user: {
          home = {
            username = user;
            homeDirectory = "/home/${user}";
            stateVersion = config.system.stateVersion;
          };
          systemd.user.startServices = "sd-switch";
        })
        cfg.users);
    };
  };
}
