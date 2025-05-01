{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Import NixOS WSL
    inputs.nixos-wsl.nixosModules.wsl
  ];

  environment.systemPackages = with pkgs; [
    # Wget for Remote VSCode
    wget
  ];

  # NixOS WSL module
  # configuration
  wsl = {
    enable = true;
    usbip.enable = true;
    defaultUser = "nixos";
    startMenuLaunchers = true;
  };

  modules = {
    system = {
      # Enable boot, localtime, nix
      # and network-manager
      enable = true;

      # Disable boot module
      boot.enable = lib.mkForce false;

      # Enable Home Manager as
      # NixOS module
      hm.enable = true;
      hm.modules = [./home.nix];

      # Configure system users
      # settings
      users = {
        nixos = {
          shell = "zsh";
          groups = ["wheel" "networkmanager"];
        };
      };
    };

    services = {
      # Enable openssh service with
      # password authentication
      ssh.enable = true;
      ssh.passwordAuth = true;

      # Enable tailscale
      tailscale.enable = true;
    };
  };
}
