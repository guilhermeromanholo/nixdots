{
  keymaps = [
    {
      mode = ["n"];
      key = "<leader>bq";
      action = "<cmd>bdelete<cr>";
      options.desc = "Close buffer";
    }
    {
      mode = ["n"];
      key = "<S-l>";
      action = "<cmd>bnext<cr>";
      options.desc = "Focus next buffer";
    }
    {
      mode = ["n"];
      key = "<S-h>";
      action = "<cmd>bprev<cr>";
      options.desc = "Focus previous buffer";
    }
  ];
}
