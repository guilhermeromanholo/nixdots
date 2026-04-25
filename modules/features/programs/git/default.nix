{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;

      settings.aliases = {
	st = "status";
	cm = "commit";
	ck = "checkout";
      };
    };
  };
}
