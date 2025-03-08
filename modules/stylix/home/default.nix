{
  inputs,
  lib,
  config,
  options,
  pkgs,
  ...
}: let
  cfg = config.modules.stylix;
  theme = import ../themes/${cfg.theme};
in {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ../shared/options.nix
  ];

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (import ../shared/core.nix {inherit theme pkgs;})
      (import ../shared/home.nix {inherit theme pkgs;})
    ]
  );
}
