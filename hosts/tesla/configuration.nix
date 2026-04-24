{
  pkgs,
  flake,
  config,
  inputs,
  ...
}: {
  imports = [
    # Core
    flake.nixosModules.nix
    flake.nixosModules.audio
    flake.nixosModules.system
    flake.nixosModules.printer

    # Desktop
    flake.nixosModules.sway
    flake.nixosModules.gnome

    # Disko
    ./disko.nix
    inputs.disko.nixosModules.disko

    # Hardware
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
  ];

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
    };
  };

  # SSH
  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  networking.networkmanager.plugins = [
    pkgs.networkmanager-openvpn
  ];

  # GNUPG
  services.pcscd.enable = true;

  programs.gnupg.agent = {
     enable = true;
     pinentryPackage = pkgs.pinentry-curses;
  };

  # Docker
  programs.dconf.enable = true;
  virtualisation.docker.enable = true;

  # Modules
  modules = {
    system.uefi = true;
    system.hostname = "tesla";
    system.stateVersion = "24.11";

    system.keymap = "br-abnt2";
    system.locale = "pt_BR.UTF-8";
    system.timezone = "America/Sao_Paulo";

    system.users.guilherme.groups = [
      "networkmanager"
      "wheel"
    ];

    gnome.xkb.layout = "br";
    gnome.xkb.variant = "thinkpad";

    printer.drivers = [pkgs.gutenprint];
  };

  # Services
  services.tailscale.enable = true;

  # Programs
  programs.git.enable = true;
  programs.steam.enable = true;
  programs.direnv.enable = true;
  programs.firefox.enable = true;
  programs.virt-manager.enable = true;

  environment.systemPackages = [
    inputs.nixvim.packages.${pkgs.system}.default

    pkgs.docker
    pkgs.docker-compose

    pkgs.obsidian
    pkgs.wireguard-tools
  ];

  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    openvpn
    nerd-fonts.jetbrains-mono
  ];
}
