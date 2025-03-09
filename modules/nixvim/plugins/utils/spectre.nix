{
  plugins.spectre.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>rs";
      action = ":Spectre<CR>";
      options = {
        desc = "Spectre Toggle";
        silent = true;
      };
    }
  ];
}
