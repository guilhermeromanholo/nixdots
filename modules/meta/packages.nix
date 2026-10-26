{
  self,
  inputs,
  lib,
  ...
}:
{
  # Wrappers depend on the original pkgs.<program>, never on self.packages.
  # Dependencies between configured programs use the lazy pkgs.nixdots namespace.
  flake.lib.mkOverlay = theme: final: prev: {
    nixdots = lib.mapAttrs (
      _: wrapper:
      wrapper.wrap {
        pkgs = final;
        inherit theme;
      }
    ) self.wrappers;
    capitaine-cursors-themed = prev.capitaine-cursors-themed.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        cd "$out/share/icons"
        for variant in Nord Gruvbox; do
          if [ -d "Capitaine Cursors ($variant)" ]; then
            mv "Capitaine Cursors ($variant)" "Capitaine-Cursors-$variant"
          fi
        done
      '';
    });
  };
  flake.overlays = {
    default = self.lib.mkOverlay self.themes.gruvbox;
    nord = self.lib.mkOverlay self.themes.nord;
  };
  flake.modules.nixos.packages = { config, ... }: {
    nixpkgs.overlays = [ (self.lib.mkOverlay config.nixdots.theme) ];
    nixpkgs.config.allowUnfree = true;
  };
  perSystem = { system, pkgs, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ self.overlays.default ];
    };
    packages.default = pkgs.nixdots.helix;
    formatter = pkgs.nixfmt;
  };
}
