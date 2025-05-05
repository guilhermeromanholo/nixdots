{
  imports = [
    ./mini

    ./lsp/lsp.nix
    ./lsp/conform.nix
    ./lsp/lspsaga.nix

    ./git/gitsigns.nix

    ./tree/neotree.nix
    ./tree/treesitter.nix

    ./completion/cmp.nix
    ./completion/lspkind.nix

    ./snippets/luasnip.nix

    ./utils/spectre.nix
    ./utils/whichkey.nix
    ./utils/floaterm.nix
    ./utils/autopairs.nix
    ./utils/guess-ident.nix
    ./utils/live-server.nix
    ./utils/todo-comments.nix
    ./utils/markdown-preview.nix

    # ./ui/precognition.nix
    ./ui/noice.nix
    ./ui/alpha.nix
    ./ui/lualine.nix
    ./ui/bufferline.nix
    ./ui/toggleterm.nix
    ./ui/vim-css-color.nix
  ];
}
