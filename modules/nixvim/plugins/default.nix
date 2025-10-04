{
  imports = [
    ./ui/mini.nix
    ./ui/noice.nix
    ./ui/lualine.nix
    ./ui/bufferline.nix

    ./lsp/servers.nix

    ./treesitter/base.nix

    ./completion/blink.nix
  ];
}
