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
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
  ];

  # Modules
  modules = {
    system = {
      uefi = true;
      hostname = "tesla";
      stateVersion = "24.11";

      keymap = "br-abnt2";
      locale = "pt_BR.UTF-8";
      timezone = "America/Sao_Paulo";

      users.guilherme.groups = ["networkmanager" "wheel"];
    };

    gnome = {
      xkb.layout = "br";
      xkb.variant = "thinkpad";
    };
  };

  # Services
  services.tailscale.enable = true;
  services.printing.enable = true;

  # Programs
  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;
}
