{
  theme,
  lib,
  options,
  ...
}: lib.optionalAttrs (options.programs ? hyprpanel) {
  programs.hyprpanel.settings.theme.name = "${theme.name}_split";
}
