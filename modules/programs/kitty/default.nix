{
  flake.modules.homeManager.kitty = {
    programs.kitty = {
      enable = true;

      settings = {
        enable_audio_bell = false;
        allow_hyperlinks = true;
        cursor_trail = 200;
      };
    };
  };
}
