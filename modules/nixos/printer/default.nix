let
  cfg = config.modules.printer;
in {
  imports = [./options.nix];

  services = {
    # Enable CUPS
    printing = {
      enable = true;
      drivers = cfg.drivers;
    };

    # Enable Network Discover
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  # Enable Scanner
  hardware.sane.enable = true;
}
