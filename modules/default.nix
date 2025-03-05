{
  parts.modules = {
    # My system NixOS custom
    # modules
    nixosModules = {
      system = ./nixos/system;
      themes = ./nixos/themes;
      hardware = ./nixos/hardware;
      sessions = ./nixos/sessions;
      services = ./nixos/services;
      impermanence = ./impermanence/nixos;
    };

    # My Home Manager custom
    # modules
    homeManagerModules = {
      shell = ./home-manager/shell;
      desktop = ./home-manager/desktop;
      editors = ./home-manager/editors;
      programs = ./home-manager/programs;
      impermanence = ./impermanence/home-manager;
    };
  };
}
