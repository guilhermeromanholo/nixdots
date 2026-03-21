{
  flake.modules.nixos.fstrim = {
    services.fstim = {
      enable = true;
    };
  };
}
