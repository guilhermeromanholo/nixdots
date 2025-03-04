{
  parts.modules = {
    # My system NixOS custom
    # modules
    nixosModules = ./nixos;

    # My Home Manager custom
    # modules
    homeManagerModules = ./home-manager;
  };
}
