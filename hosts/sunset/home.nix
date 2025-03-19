{
  programs.firefox.enable = true;

  modules = {
    programs = {
      # Enable wofi to run apps
      # in Hyprland
      wofi.enable = true;

      # Enable Kitty terminal
      # emulator
      kitty.enable = true;
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
      # Enable gnome extensions
      # and customizations
      gnome.enable = true;

      # Enable Hyprland keybinds
      # and decorations
      hyprland.enable = true;
    };

    external = {
      # Enable nixcord
      nixcord.enable = true;

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
