{
  den.aspects.greeter.nixos = {
    services.displayManager.noctalia-greeter = {
      enable = true;

      settings.appearance = {
        scheme = "Synced";
        hide_logo = true;
      };
    };
  };
}
