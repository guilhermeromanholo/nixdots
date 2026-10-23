{
  flake.wrappers.kitty = {
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.wrapperModules.kitty];

    runtimePkgs = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    font = {
      size = 12;
      name = "JetBrainsMono Nerd Font";
    };

    settings = {
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";

      enable_audio_bell = "no";
      confirm_os_window_close = 0;

      background_opacity = 0.5;
    };
  };
}
