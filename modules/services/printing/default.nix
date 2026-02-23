{
  flake.modules.nixos.printing = {pkgs, ...}: {
    services = {
      # Enable CUPS
      printing = {
        enable = true;
        drivers = [pkgs.gutenprint];
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

    # GUI App
    environment.systemPackages = with pkgs; [
      system-config-printer
    ];
  };
}
