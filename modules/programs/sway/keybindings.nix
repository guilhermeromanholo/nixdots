{
  flake.modules.homeManager.sway = {
    lib,
    pkgs,
    ...
  }: {
    wayland.windowManager.sway.config = {
      modifier = "Mod4";

      keybindings = lib.mkOptionDefault {
        # Print
        "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
        "Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area";
      };
    };
  };
}
