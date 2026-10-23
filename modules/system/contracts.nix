{lib, ...}: let
  strList = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
  };
in {
  flake.modules.nixos.contracts = {
    # Persistence
    options.persist.user = {
      dirs = strList;
      files = strList;
    };

    options.persist.root = {
      dirs = strList;
      files = strList;
    };
  };
}
