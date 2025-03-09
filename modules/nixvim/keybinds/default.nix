{
  globals.mapleader = " ";

  keymaps = [
    {
      mode = "n";
      key = "<leader>";
      action = "<cmd>WhichKey<cr>";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree focus<cr>";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>bnext<cr>";
    }
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>bprev<cr>";
    }
    {
      mode = ["n" "v"];
      key = "<leader>q";
      action = "<cmd>bdelete<cr>";
    }
    {
      mode = "n";
      key = "<leader>t";
      action = "<cmd>FloatermNew<cr>";
    }
  ];
}
