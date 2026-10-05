{lib, ...}: let
  pathList = lib.mkOption {
    default = [];
    type = lib.types.listOf lib.types.str;
  };

  strOpt = lib.mkOption {
    default = "";
    type = lib.types.str;
  };
in {
  options.custom = {
    username = strOpt;

    disk = {
      size = strOpt;
      swap = strOpt;
      device = strOpt;
    };

    persist = {
      root.files = pathList;
      root.directories = pathList;

      user.files = pathList;
      user.directories = pathList;
    };
  };
}
