{
  programs.firefox.enable = true;

  modules = {
    programs = {
      # Enable Kitty terminal
      # emulator
      kitty.enable = true;

      # Enable Wofi program
      # launcher
      wofi.enable = true;
    };

    editors = {
      # Enable Zed editor with
      # custom plugins
      zed.enable = true;

      # Enable nixvim with my
      # personal config
      nixvim.enable = true;
    };

    # Shell utils modules
    shell = {
      nh.enable = true;
      git.enable = true;
      zsh.enable = true;
    };

    desktop = {
      # Enable Sway customizations
      sway.enable = true;
    };
  };
}
