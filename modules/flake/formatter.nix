{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt.programs = {
    taplo.enable = true; # TOML
    alejandra.enable = true; # Nix
  };
}
