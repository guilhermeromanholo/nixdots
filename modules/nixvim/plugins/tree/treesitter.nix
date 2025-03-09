{
  plugins.treesitter = {
    enable = true;

    settings = {
      highlight = {
        enable = true;
      };

      indent = {
        enable = true;
      };

      folding = {
        enable = true;
      };

      ensure_installed = [
        "c"
        "bash"
        "nix"
        "java"
        "python"
        "markdown"
        "yaml"
        "json"
      ];

      auto_install = true;
    };

    nixvimInjections = true;
  };
}
