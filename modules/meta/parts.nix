{ inputs, lib, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-aspects.flakeModule
  ];

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };

  config = {
    systems = [ "x86_64-linux" ];

    perSystem.treefmt.programs = {
      nixfmt.enable = true;
      deadnix.enable = true;
    };
  };
}
