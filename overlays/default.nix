{
  inputs,
  lib,
  config,
  ...
}: {
  parts.overlays = {
    # This one brings our custom packages from the 'pkgs' directory
    additions = final: _prev:
      lib.mapAttrs (
        _: value: final.pkgs.callPackage value {}
      )
      config.parts.packages;

    # This one contains whatever you want to overlay
    # https://nixos.wiki/wiki/Overlays
    modifications = final: prev: {
      gruvbox-gtk-theme = import ./gruvbox-gtk-theme {inherit prev;};
      capitaine-cursors-themed = import ./capitaine-cursors-themed {inherit prev;};
    };

    # Accessible through 'pkgs.stable'
    stable-packages = final: _prev: {
      stable = import inputs.nixpkgs-stable {
        system = final.system;
        config.allowUnfree = true;
      };
    };

    # Hyprpanel overlay
    hyprpanel = inputs.hyprpanel.overlay;

    # NUR Overlay
    nur = inputs.nur.overlays.default;
  };
}
