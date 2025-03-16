{
  programs.firefox.enable = true;

  modules = {
    # Personalized programs in the
    # home-manager modules
    programs = {
      kitty.enable = true;
    };

    # Custom code editors
    editors = {
      zed.enable = true;
      nixvim.enable = true;
    };

    # Shell utils modules
    shell = {
      nh.enable = true;
      git.enable = true;
      zsh.enable = true;
    };

    # Desktop customization
    # modules
    desktop = {
      gnome.enable = true;
    };

    external = {
      # Impermanence module
      # persistent files
      impermanence = {
        enable = true;

        dirs = [
          ".ssh"
          ".mozilla"
          ".nixdots"
          "Documentos"
        ];

        files = [
          ".gitconfig"
        ];
      };
    };
  };
}
