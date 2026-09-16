{
  inputs,
  den,
  ...
}: {
  #---------#
  # Imports #
  #---------#

  imports = [
    inputs.den.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  #----------#
  # Defaults #
  #----------#

  den.default.includes = [
    den.batteries.inputs'
    den.batteries.hostname
    den.batteries.define-user
  ];

  #-----------#
  # Formatter #
  #-----------#

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      taplo.enable = true;
      alejandra.enable = true;
    };
  };
}
