{
  inputs,
  lib,
  ...
}: {
  options.flake = {
    lib = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };
  };

  config = {
    systems = [
      "x86_64-linux"
    ];

    perSystem = {pkgs, ...}: {
      formatter = pkgs.alejandra;
    };

    flake.theme =
      import
      (inputs.self + /themes/gruvbox/theme.nix);
  };
}
