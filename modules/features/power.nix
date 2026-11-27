{
  flake.nixosModules.power = {
    key = "nixdots:modules/hardware/power.nix:power";
    services.tlp.enable = true;
    services.upower.enable = true;
  };
}
