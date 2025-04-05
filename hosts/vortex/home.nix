{
  modules = {
    editors = {
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
  };
}
