{
  imports = [
    ./ui/mini.nix
    ./ui/noice.nix
    ./ui/lualine.nix
    ./ui/nvim-tree.nix
    ./ui/bufferline.nix

    ./lsp/servers.nix
    ./lsp/lspsaga.nix

    ./utils/which-key.nix
    ./utils/autopairs.nix
    ./utils/treesitter.nix
    ./utils/toggleterm.nix

    ./completion/blink.nix
    ./completion/snippets.nix
  ];
}
