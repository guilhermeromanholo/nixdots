{ inputs, ... }:
{
  imports = [
    inputs.den.flakeModule
    inputs.treefmt-nix.flakeModule
    inputs.wrappers.flakeModules.default
  ];

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
  };
}
