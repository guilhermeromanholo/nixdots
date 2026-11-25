{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.lib.mkOverlay = theme: final: _prev: {
    my = lib.mapAttrs (
      _: w:
      w.wrap {
        pkgs = final;
        inherit theme;
      }
    ) inputs.self.wrappers;
  };

  flake.overlays = {
    nord = self.lib.mkOverlay self.themes.nord;
    gruvbox = self.lib.mkOverlay self.themes.gruvbox;
  };

  perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [ (self.lib.mkOverlay self.themes.gruvbox) ];
    };
  };
}
