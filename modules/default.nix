{
  parts.modules = {
    # My system NixOS custom
    # modules
    nixosModules = {
      stylix = ./stylix/nixos;
      system = ./nixos/system;
      hardware = ./nixos/hardware;
      sessions = ./nixos/sessions;
      services = ./nixos/services;
      impermanence = ./impermanence/nixos;
    };

    # My Home Manager custom
    # modules
    homeManagerModules = {
      shell = ./home/shell;
      stylix = ./stylix/home;
      desktop = ./home/desktop;
      editors = ./home/editors;
      programs = ./home/programs;
      impermanence = ./impermanence/home;
    };
  };
}
