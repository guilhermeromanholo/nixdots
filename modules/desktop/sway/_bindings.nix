{
  lib,
  sessionLib,
  session,
}:
let
  modifiers = {
    SUPER = "Mod4";
    SHIFT = "Shift";
    CTRL = "Control";
    ALT = "Mod1";
  };
  render =
    binding:
    let
      key = if builtins.stringLength binding.key == 1 then lib.toLower binding.key else binding.key;
      combination = lib.concatStringsSep "+" (
        map (modifier: modifiers.${modifier}) binding.modifiers ++ [ key ]
      );
    in
    "bindsym ${lib.optionalString binding.release "--release "}${combination} ${
      sessionLib.command "sway" session binding
    }";
  renderMode =
    name: bindings:
    let
      body = lib.concatMapStringsSep "\n" render (session.commonBindings ++ bindings);
    in
    if name == "default" then body else "mode \"${name}\" {\n${body}\n}";
in
sessionLib.assertValid "sway" session (
  lib.concatStringsSep "\n\n" (lib.mapAttrsToList renderMode session.bindings)
)
