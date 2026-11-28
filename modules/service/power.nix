{
  flake.modules.nixos.power = {
    services.tlp.enable = true;
    services.upower.enable = true;
  };
}
