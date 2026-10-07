{ inputs, lib, ... }:
{
  den.aspects.helix.nixos =
    { pkgs, theme, ... }:
    let
      t = lib.head theme;

      helix = inputs.wrappers.wrappers.helix.wrap {
        inherit pkgs;

        languages = import ./_languages.nix;
        settings = import ./_settings.nix { theme = t; };

        runtimePkgs = with pkgs; [
          ty
          nixd
        ];
      };
    in
    {
      environment.systemPackages = [ helix ];
    };
}
