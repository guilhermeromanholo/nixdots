{ inputs, ... }:
{
  flake.aspects.helix.nixos =
    { self', ... }:
    {
      environment.systemPackages = [
        self'.package.helix
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
