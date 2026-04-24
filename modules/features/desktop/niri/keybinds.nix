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
      "Mod+q".action = close-window;
      "Mod+f".action = fullscreen-window;
      "Mod+r".action = switch-preset-column-width;
      "Mod+e".action = toggle-column-tabbed-display;
      "Mod+Space".action = toggle-window-floating;

      # Navigation
      "Mod+h".action = focus-column-left;
      "Mod+l".action = focus-column-right;
      "Mod+k".action = focus-workspace-up;
      "Mod+j".action = focus-workspace-down;

      # Programs
      "Mod+d".action.spawn = noctalia "launcher toggle";
      "Ctrl+Alt+l".action.spawn = noctalia "lockScreen lock";
      "Mod+Return".action = spawn "${pkgs.kitty}/bin/kitty";

      # Workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;
    };
  };
}
