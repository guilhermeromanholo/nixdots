{
  keymaps = [
    {
      mode = ["n"];
      key = "<leader>eo";
      action = "<cmd>NvimTreeOpen<cr>";
      options.desc = "Open explorer";
    }
    {
      mode = ["n"];
      key = "<leader>eq";
      action = "<cmd>NvimTreeClose<cr>";
      options.desc = "Close explorer";
    }
    {
      mode = ["n"];
      key = "<leader>ef";
      action = "<cmd>NvimTreeFocus<cr>";
      options.desc = "Focus explorer";
    }
  ];
}
