{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-aspects.flakeModule
  ];

  systems = [
    "x86_64-linux"
  ];

  perSystem.treefmt.programs = {
    taplo.enable = true;
    alejandra.enable = true;
  };
}
