{
  theme,
  lib,
  options,
  ...
}:
lib.optionalAttrs (options.programs ? nixvim) {
  programs.nixvim.colorschemes.${theme.name}.enable = true;
}
