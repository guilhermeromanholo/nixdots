{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.wrappers.flakeModules.wrappers
    inputs.flake-parts.flakeModules.modules
  ];

  options.flake = {
    factory = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };

    lib = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };
  };

  config = {
    systems = [
      "x86_64-linux"
    ];

    perSystem.treefmt.programs = {
      taplo.enable = true; # TOML
      alejandra.enable = true; # Nix
    };

    flake.theme =
      import
      (inputs.self + /themes/gruvbox/theme.nix);
  };
}
