{
  theme,
  lib,
  options,
  ...
}: lib.optionalAttrs (options.programs ? hyprpanel) {
  programs.hyprpanel.theme = "${theme.name}_split";
}
