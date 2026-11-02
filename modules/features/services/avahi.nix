{
  flake.modules.nixos.avahi = {
    services.avahi.enable = true;
    serivces.avahi.nssmdns4 = true;
  };
}
