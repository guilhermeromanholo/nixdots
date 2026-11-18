{
  flake.nixosModules.gtk = {
    programs.dconf = {
      enable = true;
    };
  };
}
