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

    xkb_rules_layout = "br";

    bind = [
      "SUPER, Q, killclient"
      "SUPER, Return, spawn, ${lib.getExe kitty}"
      "SUPER, D, spawn, ${lib.getExe noctalia} msg panel-toggle launcher"
      "CTRL+ALT, L, spawn, ${lib.getExe noctalia} msg session lock"

      "SUPER, H, focusdir, left"
      "SUPER, L, focusdir, right"
      "SUPER, K, focusdir, up"
      "SUPER, J, focusdir, down"

      "SUPER, W, togglejump"
      "ALT, Tab, overcircle, next"

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

      "SUPER+SHIFT,1,tag,1"
      "SUPER+SHIFT,2,tag,2"
      "SUPER+SHIFT,3,tag,3"
      "SUPER+SHIFT,4,tag,4"
      "SUPER+SHIFT,5,tag,5"
      "SUPER+SHIFT,6,tag,6"
      "SUPER+SHIFT,7,tag,7"
      "SUPER+SHIFT,8,tag,8"
      "SUPER+SHIFT,9,tag,9"
      "SUPER+SHIFT,0,tag,0"
    ];

    tagrule = [
      "id:1,layout_name:tile"
      "id:2,layout_name:scroller"
    ];

    jump_labels = "HJKLASDFGQWERTYUIOPZXCVBNM";
  };

  autostart_sh = "${lib.getExe noctalia} &";
}
