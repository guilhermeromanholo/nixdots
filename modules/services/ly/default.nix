{
  flake.modules.nixos.ly = {
    services.displayManager.ly = {
      enable = true;
      settings = {
	bigclock = true;

	brightness_up_key = "null";
	brightness_down_key = "null";

	hide_version_string = true;
      };
    };
  };
}
