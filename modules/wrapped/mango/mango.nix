{
  inputs,
  lib,
  moduleWithSystem,
  ...
}:
{
  flake.aspects.mango.nixos = moduleWithSystem (
    { self' }:
    {
      programs.mango = {
        enable = true;
        package = self'.packages.mango;
      };
    }
  );

  perSystem =
    { self', pkgs, ... }:
    let
      kitty = lib.getExe pkgs.kitty;
      noctalia = lib.getExe self'.packages.noctalia;
    in
    {
      packages.mango = inputs.wrappers.wrappers.mangowc.wrap {
        inherit pkgs;

        settings = {
          blur = 1;
          blur_optimized = 1;
          blur_params = {
            radius = 5;
            num_passes = 2;
          };

          shadows = 1;
          shadows_size = 10;
          shadows_blur = 15;
          shadows_position_x = 0;
          shadows_position_y = 0;
          shadowscolor = "0x000000ff";

          borderpx = 1;
          border_radius = 6;

          gappih = 8;
          gappiv = 8;

          bind = [
            "Alt, Q, killclient"
            "Alt, Return, spawn, ${kitty}"
            "Alt, D, spawn, ${noctalia} msg panel-toggle launcher"
          ];

          tagrule = [
            "id:1,layout_name:tile"
            "id:2,layout_name:scroller"
          ];
        };

        autostart_sh = "${noctalia} &";
      };
    };
}
