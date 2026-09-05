{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-parts.flakeModules.modules
  ];

  #-----------#
  #  Options  #
  #-----------#

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  options.flake.factory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  #----------#
  #  Config  #
  #----------#

  config.systems = [
    "x86_64-linux"
  ];

  config.perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      taplo.enable = true;
      alejandra.enable = true;
    };
  };
}
