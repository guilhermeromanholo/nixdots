{ inputs, den, ... }:
{
  imports = [
    inputs.den.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  systems = [ "x86_64-linux" ];

  den.default.includes = [
    den.batteries.hostname
    den.batteries.define-user
  ];

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
  };
}
