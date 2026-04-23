{
  flake.modules.homeManager.niri = {
    programs.niri.settings.spawn-at-startup = [
      {command = ["xwayland-satellite"];}
      {command = ["noctalia-shell"];}
    ];
  };
}
