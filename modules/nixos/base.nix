{self, ...}: {
  flake.nixosModules.base = {
    imports = [
      self.nixosModules.network
    ];

    # Locale
    time.timeZone = "America/Sao_Paulo";
    i18n.defaultLocale = "pt_BR.UTF-8";
    time.hardwareClockInLocalTime = true;

    # Nix Settings
    nix.settings = {
      trusted-users = ["@wheel"];
      auto-optimise-store = true;
      experimental-features = ["nix-command flakes"];
    };

    nix.optimise.automatic = true;

    # Garbage Collector
    nix.gc = {
      automatic = true;
      randomizedDelaySec = "24h";
      options = "--delete-older-than 3d";
    };

    # Firmware
    services.fwupd.enable = true;
    hardware.enableRedistributableFirmware = true;

    # Version
    system.stateVersion = "26.11";
  };
}
