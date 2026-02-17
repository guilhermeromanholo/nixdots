{
  flake.modules.homeManager.sway = {
    lib,
    pkgs,
    ...
  }: {
    wayland.windowManager.sway = {
      config.keybindings = lib.mkOptionDefault {
        # Swaylock
        "Ctrl+Alt+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";

        # Print Screen
        "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
        "Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area";
      };
    };
  };
}
