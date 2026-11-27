{
  flake.nixosModules.sway = { pkgs, ... }: {
    key = "nixdots:modules/desktop/sway/default.nix:sway";
    programs.sway = {
      enable = true;
      package = pkgs.my.sway;
      extraPackages = [ ];
    };
    session.compositor = "sway";
  };
}
