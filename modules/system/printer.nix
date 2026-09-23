{
  flake.nixosModules.printer = {pkgs, ...}: {
    # CUPS
    services.printing = {
      enable = true;
      drivers = [pkgs.gutenprint];
    };

    # Network Discovery
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Scanner
    hardware.sane.enable = true;
  };
}
