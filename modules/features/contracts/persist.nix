{ lib, ... }:
let
  strList = lib.mkOption {
    default = [ ];
    type = lib.types.listOf lib.types.str;
  };
in
{
  flake.modules.nixos.persist = {
    options.persist = {
      root.files = strList;
      root.directories = strList;

      user.files = strList;
      user.directories = strList;
    };
  };
}
