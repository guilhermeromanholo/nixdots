{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "tesla";
    networkmanager.enable = true;
  };

  # Localtime
  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # X11
  services.xserver = {
    enable = true;

    xkb.layout = "br";
    xkb.variant = "thinkpad";
  };

  # Gnome
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Tailscale
  services.tailscale.enable = true;

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Users
  users.users.guilherme = {
    isNormalUser = true;
    description = "guilherme";
    extraGroups = ["networkmanager" "wheel"];
  };

  # Programs
  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.firefox.enable = true;

  # Nix
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["flakes" "nix-command"];

  system.stateVersion = "24.11";
}
