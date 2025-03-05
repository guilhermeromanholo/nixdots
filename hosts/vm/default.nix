{inputs, ...}: {
  imports = [
    # Import Disko module
    ./disko.nix
    inputs.disko.nixosModules.disko

    # Import hardware config
    ./hardware.nix
  ];

  modules = {
    system = {
      # Enable boot, localtime, nix
      # and network-manager
      enable = true;

      # Configure system users
      # settings
      users = {
        nixos = {
          shell = "fish";
          groups = ["wheel" "networkmanager"];
        };
      };

      # Enable Home Manager as
      # NixOS module
      hm = {
        enable = true;
        modules = [./home.nix];
      };
    };

    hardware = {
      # Enable pipewire audio
      # controller
      audio.enable = true;
    };

    themes = {
      # Enable features for every
      # theme like fonts
      enable = true;

      # Enable gruvbox theme with
      # stylix
      gruvbox.enable = true;
    };

    services = {
      # Enable openssh service with
      # password authentication
      ssh = {
        enable = true;
        passwordAuth = true;
      };
    };

    sessions = {
      # Enable base configurations
      # for graphical sessions like
      # xserver, opengl and regreet
      enable = true;

      # Enable gnome desktop environment
      # without bloatware
      gnome.enable = true;
    };
  };
}
