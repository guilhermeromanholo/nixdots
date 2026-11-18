{ lib, ... }:
{
  flake.nixosModules.options = {
    options.settings = {
      user = {
        # User name
        name = lib.mkOption {
          default = "glhrm";
          type = lib.types.str;
        };
      };
    };
  };
}
