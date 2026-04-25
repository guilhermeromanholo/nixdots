{
  flake.modules.homeManager.niri = {
    programs.niri.settings = {
      hotkey-overlay = {
        skip-at-startup = true;
      };

      spawn-at-startup = [
        {command = ["xwayland-satellite"];}
        {command = ["noctalia-shell"];}
      ];
    };
  };
}
