{
  inputs,
  flake,
  ...
}: {
  imports = [
    # Core
    flake.nixosModules.nix
    flake.nixosModules.audio
    flake.nixosModules.system

    # Desktop
    flake.nixosModules.gnome

    # Hardware
    ./disko.nix
    ./hardware.nix
    inputs.disko.nixosModules.disko
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
  services.printing.enable = true;

  # Programs
  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;
}
