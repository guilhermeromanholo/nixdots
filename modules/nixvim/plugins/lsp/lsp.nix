{
  plugins = {
    lsp-format.enable = true;

    lsp = {
      enable = true;
      servers = {
        # C/C++
        clangd = {
          enable = true;
          autostart = true;
        };
        # Nix
        nixd = {
          enable = true;
          autostart = true;
        };
        # Nix
        pyright = {
          enable = true;
          autostart = true;
        };
      };
    };
  };
}
