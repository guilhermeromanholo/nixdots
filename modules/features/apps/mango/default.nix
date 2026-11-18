{
  flake.nixosModules.mango = { pkgs, ... }: {
    programs.mango.enable = true;
    programs.mango.package = pkgs.my.mango;
  };
}
