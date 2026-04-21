{
  flake.modules.homeManager.noctalia = {
    programs.noctalia-shell.settings.bar = {
      density = "comfortable";
      position = "left";
      barType = "simple";

      widgets = {
	left = [
	  {id = "ControlCenter"; useDistroLogo = true; colorizeIcons = true;}
	  {id = "SystemMonitor";}
	  {id = "MediaMini";}
	];

	center = [
	  {id = "Workspace";}
	];

	right = [
	  {id = "Tray";}
	  {id = "Battery";}
	  {id = "Network";}
	  {id = "Volume";}
	  {id = "Clock"; formatVertical = "HH mm";}
	  {id = "SessionMenu";}
	];
      };
    };
  };
}
