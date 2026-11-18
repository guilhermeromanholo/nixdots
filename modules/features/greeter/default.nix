{
  flake.nixosModules.greeter = {
    services.displayManager.noctalia-greeter = {
      enable = true;
    };
  };
}
