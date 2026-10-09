{ inputs, pkgs, ... }:
inputs.wrappers.wrappers.helix.wrap {
  inherit pkgs;

  runtimePkgs = with pkgs; [
    ty
    nixd
  ];

  settings = import ./settings.nix {
    inherit (inputs.self) theme;
  };

  languages = import ./languages.nix;
}
