{ lib, ... }:
let
  strOpt =
    description:
    lib.mkOption {
      inherit description;
      type = lib.types.str;
    };
in
{
  flake.modules.nixos.settings = {
    options.settings.disk = {
      size = strOpt "Root partition size";
      swap = strOpt "Swap partition size";
      device = strOpt "Disk device name";
    };
  };
}
