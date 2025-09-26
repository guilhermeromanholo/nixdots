{
  inputs,
  system,
  flake,
  pkgs,
  ...
}:
inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
  inherit pkgs;
  module = flake.modules.nixvim.default;
}
