{
  flake.modules.nixos.ly = {
    services.displayManager.ly = {
      enable = true;
      settings = {
	bigclock = true;
      };
    };
  };
}
