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
      shell = ./home/shell;
      desktop = ./home/desktop;
      editors = ./home/editors;
      programs = ./home/programs;
      impermanence = ./impermanence/home;
    };
  };
}
