{
  flake.nixosModules.kitty = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.my.kitty
    ];
  };
}
