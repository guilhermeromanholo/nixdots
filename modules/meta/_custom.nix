{lib, ...}: let
  pathList = lib.mkOption {
    default = [];
    type = lib.types.listOf lib.types.str;
  };

  strList = lib.mkOption {
    default = "";
    type = lib.types.str;
  };
in {
  options.custom = {
    disk = {
      size = strList;
      swap = strList;
      device = strList;
    };

    persist = {
      root.files = pathList;
      root.directories = pathList;

      user.files = pathList;
      user.directories = pathList;
    };
  };
}
