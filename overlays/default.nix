{
  inputs,
  lib,
  config,
  ...
}: {
  flake.overlays = {
    # This one brings our custom packages from the 'pkgs' directory
    additions = final: _prev:
      lib.mapAttrs (
        _: value: final.pkgs.callPackage value {}
      )
      config.parts.packages;

    # This one contains whatever you want to overlay
    # https://nixos.wiki/wiki/Overlays
    modifications = final: prev: {
      # Fix the issue: https://github.com/NixOS/nixpkgs/issues/388522
      gruvbox-plus-icons = prev.gruvbox-plus-icons.overrideAttrs (oldAttrs: {
        postFixup = ''
          find $out/share/icons/Gruvbox-Plus-Dark -xtype l -delete
        '';
      });

      # example = prev.example.overrideAttrs (oldAttrs: rec {
      #
      # });
    };

    # Accessible through 'pkgs.stable'
    stable-packages = final: _prev: {
      stable = import inputs.nixpkgs-stable {
        system = final.system;
        config.allowUnfree = true;
      };
    };
  };
}
