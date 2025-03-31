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

  modules = {
    system = {
      # Enable boot, localtime, nix
      # and network-manager
      enable = true;

      # Enable uefi and os-prober
      boot.uefi = true;

      # Enable Home Manager as
      # NixOS module
      hm.enable = true;
      hm.modules = [./home.nix];

      # Configure system users
      # settings
      users = {
        guilherme = {
          shell = "zsh";
          groups = ["wheel" "networkmanager"];
        };
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
      ssh.enable = true;
      ssh.passwordAuth = true;

      # Enable tailscale
      tailscale.enable = true;
    };

    sessions = {
      # Enable base configurations
      # for graphical sessions like
      # xserver, opengl and gdm
      enable = true;

      # Enable gnome desktop environment
      # without bloatware
      gnome.enable = true;
    };

    style = {
      # Enable features for
      # theming NixOS
      enable = true;
      theme = outputs.themes.gruvbox;
    };
  };
}
