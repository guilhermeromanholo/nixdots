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
      vim.enable = true;
    };

    # Custom shell modules
    shell = {
      git.enable = true;
      zsh.enable = true;
    };

    # Impermanence module
    # persistent files
    impermanence = {
      enable = true;

      directories = [
        ".mozilla"
      ];
    };
  };
}
