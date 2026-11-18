{ inputs, lib, ... }:
{
  flake.overlays.default = final: _prev: {
    my = lib.mapAttrs (_: w: w.wrap { pkgs = final; }) inputs.self.wrappers;
  };
}
