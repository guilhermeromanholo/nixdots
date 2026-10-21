{ self, ... }: {
  flake.wrappers.mango =
    {
      config,
      wlib,
      pkgs,
      lib,
      ...
    }:
    let
      t = config.theme;
      noctalia = lib.getExe pkgs.nixdots.noctalia;
      oldKeys = lib.versionOlder pkgs.mango.version "0.18.0";
      key = before: after: if oldKeys then before else after;
    in
    {
      imports = [
        wlib.wrapperModules.mangowc
        self.modules.generic.wrapper-theme
      ];
      package = pkgs.mango;
      autostart_sh = ''
        ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE
        ${noctalia} &
        ${lib.getExe pkgs.swaybg} -i ${t.wallpaper} -m fill &
      '';
      settings = {
        xkb_rules_layout = "br";
        ${key "borderpx" "border_px"} = 2;
        ${key "bordercolor" "border_color"} = "0x${lib.removePrefix "#" t.semantic.surface}ff";
        ${key "focuscolor" "focus_color"} = "0x${lib.removePrefix "#" t.semantic.accent}ff";
        ${key "gappih" "gap_inner_horizontal"} = 4;
        ${key "gappiv" "gap_inner_vertical"} = 4;
        ${key "gappoh" "gap_outer_horizontal"} = 8;
        ${key "gappov" "gap_outer_vertical"} = 8;
        tag_num = 9;
        blur_layer = 0;
        layer_shadows = 0;
        tap_to_click = 1;
        bind = [
          "SUPER,Return,spawn,${lib.getExe pkgs.nixdots.kitty}"
          "SUPER,d,spawn,${noctalia} msg panel-toggle launcher"
          "SUPER,space,spawn,${noctalia} msg panel-toggle launcher"
          "SUPER,s,spawn,${noctalia} msg panel-toggle control-center"
          "SUPER,comma,spawn,${noctalia} msg settings-toggle"
          "CTRL+ALT,l,spawn,${noctalia} msg lock"
          "SUPER+SHIFT,q,killclient,"
          "SUPER,f,togglefullscreen,"
          "SUPER+SHIFT,space,togglefloating,"
          "SUPER,m,quit,"
          "SUPER,h,focusdir,left"
          "SUPER,j,focusdir,down"
          "SUPER,k,focusdir,up"
          "SUPER,l,focusdir,right"
          "SUPER+SHIFT,h,move_client,left"
          "SUPER+SHIFT,j,move_client,down"
          "SUPER+SHIFT,k,move_client,up"
          "SUPER+SHIFT,l,move_client,right"
          "NONE,Print,spawn,${noctalia} msg screenshot-region"
          "SHIFT,Print,spawn,${noctalia} msg screenshot-fullscreen"
          "NONE,XF86AudioRaiseVolume,spawn,${noctalia} msg volume-up"
          "NONE,XF86AudioLowerVolume,spawn,${noctalia} msg volume-down"
          "NONE,XF86AudioMute,spawn,${noctalia} msg volume-mute"
          "NONE,XF86MonBrightnessUp,spawn,${noctalia} msg brightness-up"
          "NONE,XF86MonBrightnessDown,spawn,${noctalia} msg brightness-down"
        ]
        ++ lib.concatMap (n: [
          "SUPER,${toString n},view,${toString n}"
          "SUPER+SHIFT,${toString n},tag,${toString n}"
        ]) (lib.range 1 9);
        mousebind = [
          "SUPER,btn_left,moveresize,curmove"
          "SUPER,btn_right,moveresize,curresize"
        ];
      };
      env = {
        XDG_CURRENT_DESKTOP = "mango";
        XDG_SESSION_DESKTOP = "mango";
        XDG_SESSION_TYPE = "wayland";
        XCURSOR_THEME = t.cursor.name;
        XCURSOR_SIZE = toString t.cursor.size;
      };
      filesToPatch = [ "share/wayland-sessions/mango.desktop" ];
    };
  flake.modules.nixos.mango = { pkgs, ... }: {
    programs.mango = {
      enable = true;
      package = pkgs.nixdots.mango;
    };
    programs.xwayland.enable = true;
    # Correct the interface spelling in the upstream module for this portal.
    xdg.portal.config.mango."org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
  };
}
