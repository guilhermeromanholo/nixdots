{ lib, ... }:
{
  flake.modules.wrappers.theme = {
    options.theme = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = { };
    };
  };
}
