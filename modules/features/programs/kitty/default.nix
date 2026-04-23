{
  flake.modules.homeManager.kitty = {
    programs.kitty = {
      enable = true;

      settings = {
        cursor_trail = 200;
        allow_hyperlinks = true;
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
    };
  };
}
