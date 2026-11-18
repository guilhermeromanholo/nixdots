{
  flake.nixosModules.kitty = { pkgs, ... }: {
    programs.kitty.enable = true;
    programs.kitty.package = pkgs.my.kitty;
  };
}
