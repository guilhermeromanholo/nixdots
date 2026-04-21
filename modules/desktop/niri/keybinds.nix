{
  flake.modules.homeManager.niri = {
    config,
    pkgs,
    lib,
    ...
  }: let
    noctalia = cmd: ["noctalia-shell" "ipc" "call"] ++ (lib.splitString " " cmd);
  in {
    programs.niri.settings.binds = with config.lib.niri.actions; {
      # Windows
      "super+q".action = close-window;
      "super+f".action = fullscreen-window;
      "super+Space".action = toggle-window-floating;

      # Navigation
      "super+h".action = focus-column-left;
      "super+l".action = focus-column-right;
      "super+k".action = focus-workspace-up;
      "super+j".action = focus-workspace-down;

      # Programs
      "super+d".action.spawn = noctalia "launcher toggle";
      "ctrl+alt+l".action.spawn = noctalia "lockScreen lock";
      "super+Return".action = spawn "${pkgs.kitty}/bin/kitty";
    };
  };
}
