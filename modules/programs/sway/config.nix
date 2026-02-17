{
  flake.modules.homeManager.sway = {
    lib,
    config,
    pkgs,
    ...
  }: {
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;

      xwayland = true;
      checkConfig = false;
      systemd.enable = true;

      config = {
        modifier = "Mod4";

        terminal = "${pkgs.kitty}/bin/kitty";
        menu = "${pkgs.wofi}/bin/wofi --show drun -I";
        bars = lib.mkIf config.programs.waybar.enable [];

        gaps = {
          inner = 6;
          outer = 4;
        };
      };
    };
  };
}
