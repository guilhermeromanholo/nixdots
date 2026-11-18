{ inputs, lib, ... }:
{
  flake.lib.mkOverlays = final: _prev: {
    # My local packages
    my = lib.mapAttrs (_: w: w.wrap { pkgs = final; }) inputs.self.wrappers;
  };
}
