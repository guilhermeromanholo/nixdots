{ inputs, self, ... }:
{
  flake.overlays.default = self.lib.mkOverlay;

  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ self.lib.mkOverlay ];
    };
  };
}
