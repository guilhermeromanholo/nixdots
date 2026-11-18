{ inputs, lib, ... }:
let
  mkOverlay = final: _prev: {
    # Local packages
    my = lib.mapAttrs (_: w: w.wrap { pkgs = final; }) inputs.self.wrappers;
  };
in
{
  flake.overlays.default = mkOverlay;

  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ mkOverlay ];
    };
  };
}
