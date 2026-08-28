{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      kdlfmt.enable = true; # KDL
      alejandra.enable = true; # Nix
    };
  };
}
