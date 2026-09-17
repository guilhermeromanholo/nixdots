{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-parts.flakeModules.modules
  ];

  systems = ["x86_64-linux"];

  perSystem.treefmt.programs = {
    taplo.enable = true; # TOML
    alejandra.enable = true; # Nix
  };
}
