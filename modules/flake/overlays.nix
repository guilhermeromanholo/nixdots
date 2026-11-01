{ inputs, config, lib, ... }:
let
  mkOverlay = theme: final: _prev: {
    my = lib.mapAttrs (
      _: wrapper:
      wrapper.wrap {
        pkgs = final;
        inherit theme;
      }
    ) inputs.self.wrappers;
  };
in
{
  flake.overlays = {
    nord = mkOverlay config.themes.nord;
    gruvbox = mkOverlay config.themes.gruvbox;
  };
}
