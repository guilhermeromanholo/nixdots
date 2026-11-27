{ self, ... }:
{
  flake.nixosModules.nixpkgs = { config, ... }: {
    key = "nixdots:modules/system/nixpkgs.nix:nixpkgs";
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [
      (self.lib.mkOverlay {
        theme = config.settings.theme;
        inherit (config) session;
        shellPackage = config.settings.user.shell;
      })
    ];
  };
}
