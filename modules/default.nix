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
      external = ./nixos/external;
    };

    # My Home Manager custom
    # modules
    homeManagerModules = {
      shell = ./home/shell;
      desktop = ./home/desktop;
      editors = ./home/editors;
      programs = ./home/programs;
      external = ./home/external;
    };

    # My Nixvim custom
    # modules
    nixvimModules = {
      default = ./nixvim;
      plugins = ./nixvim/plugins;
      keybinds = ./nixvim/keybinds;
      settings = ./nixvim/settings;
      colorscheme = ./nixvim/colorscheme;
    };
  };
}
