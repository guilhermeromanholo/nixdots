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
      nixvim.enable = true;
    };

    # Custom shell modules
    shell = {
      git.enable = true;
      zsh.enable = true;
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
        ];

        files = [
          ".gitconfig"
        ];
      };
    };
  };
}
