{
  flake.wrappers.kitty = { wlib, ... }: {
    imports = [ wlib.wrapperModules.kitty ];

    settings = {
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      background_opacity = "0.5";
    };
  };
}
