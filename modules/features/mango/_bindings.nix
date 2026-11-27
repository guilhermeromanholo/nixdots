{
  lib,
  sessionLib,
  session,
}:
let
  render =
    binding:
    let
      modifiers = if binding.modifiers == [ ] then "NONE" else lib.concatStringsSep "+" binding.modifiers;
    in
    "${modifiers},${binding.key},${sessionLib.command "mango" session binding}";
  renderMode = bindings: {
    bind = map render (lib.filter (binding: !binding.release) bindings);
    bindr = map render (lib.filter (binding: binding.release) bindings);
  };
in
sessionLib.assertValid "mango" session {
  key_mode =
    lib.mapAttrs (_: renderMode) session.bindings
    // lib.optionalAttrs (session.common != [ ]) {
      common = renderMode session.common;
    };
}
