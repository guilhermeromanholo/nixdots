{
  inputs,
  pkgs,
  lib,
  kitty,
  noctalia,
  ...
}:
inputs.wrappers.wrappers.mangowc.wrap {
  inherit pkgs;

  runtimePkgs = [
    kitty
    noctalia
  ];

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
      "SUPER, Q, killclient"
      "SUPER, Return, spawn, ${lib.getExe kitty}"
      "SUPER, D, spawn, ${lib.getExe noctalia} msg panel-toggle launcher"

      "SUPER,1,view,1"
      "SUPER,2,view,2"
      "SUPER,3,view,3"
      "SUPER,4,view,4"
      "SUPER,5,view,5"
      "SUPER,6,view,6"
      "SUPER,7,view,7"
      "SUPER,8,view,8"
      "SUPER,9,view,9"
      "SUPER,0,view,0"
    ];

    tagrule = [
      "id:1,layout_name:tile"
      "id:2,layout_name:scroller"
    ];
  };

  autostart_sh = "${lib.getExe noctalia} &";
}
