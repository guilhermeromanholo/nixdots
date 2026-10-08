{ inputs, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.helix = inputs.wrappers.wrappers.helix.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        ty
        nixd
      ];

      settings = import ./_settings.nix {
        inherit (inputs.self) theme;
      };

      languages = import ./_languages.nix;
    };
  };
}
