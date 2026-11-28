{
  flake.modules.nixos.greeter = {
    services.displayManager.noctalia-greeter = {
      enable = true;

      settings.appearance = {
        scheme = "Synced";
        hide_logo = true;
      };
    };
  };
}
