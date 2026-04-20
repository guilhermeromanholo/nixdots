{
  flake.modules.homeManager.niri = {
    config,
    pkgs,
    ...
  }: {
    programs.niri.settings.binds = with config.lib.niri.actions; {
      "super+q".action = close-window;
      "super+Return".action = spawn "${pkgs.kitty}/bin/kitty";
    };
  };
}
