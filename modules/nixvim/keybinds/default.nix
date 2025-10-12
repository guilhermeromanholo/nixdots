{
  imports = [
    ./lsp.nix
    ./tree.nix
    ./term.nix
    ./buffer.nix
  ];

  globals = {
    mapleader = " ";
  };
}
