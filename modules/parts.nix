{ inputs, ... }:
{
  imports = [
    inputs.den.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  systems = [ "x86_64-linux" ];

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
  };
}
