{
  flake.nixosModules.theme = {
    key = "nixdots:modules/theme/nixos/qt.nix:theme";
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };
}
