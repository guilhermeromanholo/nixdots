{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.wrappers.flakeModules.default
  ];

  systems = [ "x86_64-linux" ];

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
  };
}
