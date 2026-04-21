{inputs, ...}: {
  flake.modules.homeManager.noctalia = {
    programs.noctalia-shell.settings.bar = {
      density = "comfortable";
      position = "left";
      barType = "simple";

      widgets = {
	center = [
	  {id = "Workspace";}
	];

	left = [
	  {id = "MediaMini";}
	  {id = "SystemMonitor";}
	  {id = "NotificationHistory";}
	  {id = "Tray";}
	];

	right = [
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
