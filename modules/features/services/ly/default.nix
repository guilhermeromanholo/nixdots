{
  flake.modules.nixos.ly = {
    services.displayManager.ly = {
      enable = true;
      settings = {
	xinitrc = null;
	bigclock = true;
	animation = "matrix";
      };
    };
  };
}

