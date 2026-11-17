{ lib, ... }:
let
  strList = lib.mkOption {
    default = [ ];
    type = lib.types.listOf lib.types.str;
  };
in
{
  flake.nixosModules.persist = {
    options.persist = {
      root.files = strList;
      root.directories = strList;

      user.files = strList;
      user.directories = strList;
    };
  };
}
