{inputs, ...}: {
  flake.theme =
    import
    (inputs.self + /themes/gruvbox/theme.nix);
}
