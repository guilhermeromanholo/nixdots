{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt.programs = {
    deadnix.enable = true;
    alejandra.enable = true;
  };
}
