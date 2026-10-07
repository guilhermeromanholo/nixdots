{ inputs, lib, ... }:
{
  den.aspects.helix.nixos =
    { self', theme, ... }:
    {
      environment.systemPackages = [
        (self'.packages.helix.wrap {
          settings.theme = (lib.head theme).slug;
        })
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.helix = inputs.wrappers.wrappers.helix.wrap {
        inherit pkgs;
        settings = import ./_settings.nix;
        languages = import ./_languages.nix;
        runtimePkgs = with pkgs; [
          ty
          nixd
        ];
      };
    };
}
