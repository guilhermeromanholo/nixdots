{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  systems = [
    "x86_64-linux"
  ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      taplo.enable = true;
      alejandra.enable = true;
    };
  };

  flake.theme = import (inputs.self + /themes/gruvbox/theme.nix);
}
