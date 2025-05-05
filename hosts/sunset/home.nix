{
  modules = {
    programs = {
      # Enable wofi to run apps
      # in Hyprland
      wofi.enable = true;

      # Enable Kitty terminal
      # emulator
      kitty.enable = true;

      # Enable nixcord
      nixcord.enable = true;

      # Enable firefox web
      # browser
      firefox.enable = true;
    };

    editors = {
      # Enable Zed editor with
      # custom plugins
      zed.enable = true;

      # Enable nixvim with my
      # personal config
      nixvim.enable = true;

      # Enable vscode with my
      # plugins and configs
      vscode.enable = true;
    };

    # Shell utils modules
    shell = {
      nh.enable = true;
      git.enable = true;
      zsh.enable = true;
    };

    desktop = {
      # Enable Hyprland keybinds
      # and decorations
      hyprland.enable = true;
    };

    misc = {
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
