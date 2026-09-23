{
  flake.nixosModules.core = {pkgs, ...}: {
    # Network
    networking.networkmanager = {
      enable = true;

      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };

    # Locale
    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "pt_BR.UTF-8";
    time.hardwareClockInLocalTime = true;

    # Nix
    nix = {
      settings = {
        trusted-users = ["@wheel"];
        auto-optimise-store = true;
        experimental-features = ["nix-command flakes"];
      };

      gc = {
        automatic = true;
        randomizedDelaySec = "24h";
        options = "--delete-older-than 3d";
      };
      
      optimise.automatic = true;
    };
  };
}
