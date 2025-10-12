{
  keymaps = [
    {
      mode = ["n"];
      key = "<leader>tf";
      action = "<cmd>ToggleTerm direction=float<cr>";
      options.desc = "Open float terminal";
    }
    {
      mode = ["n"];
      key = "<leader>th";
      action = "<cmd>ToggleTerm direction=horizontal<cr>";
      options.desc = "Open horizontal terminal";
    }
    {
      mode = ["n"];
      key = "<leader>tt";
      action = "<cmd>ToggleTerm direction=tab<cr>";
      options.desc = "Open tab terminal";
    }
  ];
}
