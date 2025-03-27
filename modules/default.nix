{
  imports = [
    ./parts
  ];

  parts.modules = {
    # My system NixOS custom
    # modules
    nixosModules = {
      system = ./nixos/system;
      hardware = ./nixos/hardware;
      sessions = ./nixos/sessions;
      services = ./nixos/services;
      appearance = ./nixos/appearance;
    };

    # My flake custom
    # modules
    flakeModules = {
      hosts = ./parts/hosts.nix;
      default = ./parts/default.nix;
      modules = ./parts/modules.nix;
      overlays = ./parts/overlays.nix;
      packages = ./parts/packages.nix;
    };

    # My Home Manager custom
    # modules
    homeManagerModules = {
      misc = ./home/misc;
      shell = ./home/shell;
      desktop = ./home/desktop;
      editors = ./home/editors;
      programs = ./home/programs;
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
