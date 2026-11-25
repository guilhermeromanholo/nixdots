{
  flake.nixosModules.mango = { pkgs, ... }: {
    programs.mango.enable = true;
    programs.mango.package = pkgs.my.mango;
    environment.systemPackages = [ pkgs.my.noctalia ];
  };
}
