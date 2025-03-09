{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    # Import Disko module
    ./disko.nix
    inputs.disko.nixosModules.disko

    # Import hardware config
    ./hardware.nix
  ];

  environment.systemPackages = [pkgs.vesktop];

  modules = {
    system = {
      # Enable boot, localtime, nix
      # and network-manager
      enable = true;

      boot = {
        uefi = true;
        os-prober = true;
      };

      # Configure system users
      # settings
      users = {
        guilherme = {
          shell = "zsh";
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
      # Enable SSD fstrim
      # controller
      ssd.enable = true;

      # Enable pipewire audio
      # controller
      audio.enable = true;
    };

    services = {
      # Enable openssh service with
      # password authentication
      ssh = {
        enable = true;
        passwordAuth = true;
      };

      tailscale.enable = true;
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

    external = {
      # Enable features for
      # theming NixOS
      stylix = {
        enable = true;
        theme = outputs.themes.gruvbox;
      };

      # Enable Impermanence NixOS
      # module to persistence
      impermanence.enable = true;
    };
  };
}
