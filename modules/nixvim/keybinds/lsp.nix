{
  keymaps = [
    {
      mode = ["n"];
      key = "<leader>df";
      action = "<cmd>lua vim.diagnostic.open_float()<cr>";
      options.desc = "Open float diagnostics";
    }
  ];
}
