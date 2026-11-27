{
  inputs,
  self,
  lib,
  ...
}:
{
  flake.lib.mkOverlay =
    {
      theme,
      session ? { },
      shellPackage ? null,
    }:
    final: _prev: {
      my = lib.mapAttrs (
        name: wrapper:
        wrapper.wrap (
          {
            pkgs = final;
            inherit theme;
          }
          // lib.optionalAttrs (builtins.elem name [
            "mango"
            "sway"
          ]) { inherit session; }
          // lib.optionalAttrs (name == "kitty" && shellPackage != null) { inherit shellPackage; }
        )
      ) self.wrappers;
    };

  flake.overlays = lib.mapAttrs (_: theme: self.lib.mkOverlay { inherit theme; }) self.themes;

  perSystem = { system, pkgs, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ (self.lib.mkOverlay { theme = self.defaultTheme; }) ];
    };

    wrappers.packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      mango = true;
      noctalia = true;
      sway = true;
      waybar = true;
    };
  };
}
