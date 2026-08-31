{
  flake.modules.nixos.printing = {pkgs, ...}: {
    services = {
      printing = {
        enable = true;
        drivers = [pkgs.gutenprint];
      };

      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    };

    hardware.sane.enable = true;
  };
}
