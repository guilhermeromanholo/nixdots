{self, ...}: {
  flake.modules.homeManager.niri = {
    programs.niri.settings.spawn-at-startup = [
      {command = ["noctalia-shell"];}
      {command = ["xwayland-satellite"];}
    ];
  };
}
