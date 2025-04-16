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

        # Python
        pyright = {
          enable = true;
          autostart = true;
        };

        # Html
        html = {
          enable = true;
          autostart = true;
        };

        # Tailwind
        tailwindcss = {
          enable = true;
          autostart = true;
        };
      };
    };
  };
}
