{ inputs, den, ... }:
{
  imports = [
    inputs.den.flakeModule
    inputs.treefmt-nix.flakeModule
    inputs.wrappers.flakeModules.default
  ];

  systems = [
    "x86_64-linux"
  ];

  den.default = {
    includes = [
      den.batteries.hostname
      den.batteries.define-user
    ];

    nixos.system.stateVersion = "26.11";
  };

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
  };
}
