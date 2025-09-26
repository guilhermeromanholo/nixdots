{
  pkgs,
  flake,
  inputs,
  perSystem,
  ...
}: {
  imports = [
    # Core
    flake.nixosModules.nix
    flake.nixosModules.audio
    flake.nixosModules.system

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
  };

  # Services
  services.tailscale.enable = true;

  # Programs
  programs.git.enable = true;
  programs.firefox.enable = true;

  environment.systemPackages = [
    perSystem.self.nixvim
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
