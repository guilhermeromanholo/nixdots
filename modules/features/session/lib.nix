{ lib, ... }:
let
  bindingKey =
    binding:
    lib.concatStringsSep "+" (lib.sort builtins.lessThan binding.modifiers)
    + ":"
    + lib.toLower binding.key
    + (if binding.release then ":release" else ":press");

  errors =
    backend: session:
    let
      modes = builtins.attrNames session.bindings;
      bindings = lib.concatLists (builtins.attrValues session.bindings) ++ session.common;
      bindingErrors =
        binding:
        lib.optional (
          (binding.action == null) == (binding.switchTo == null)
        ) "Each binding must specify exactly one of action and switchTo."
        ++ lib.optional (
          binding.switchTo != null && !(builtins.elem binding.switchTo modes)
        ) "Unknown binding mode: ${toString binding.switchTo}."
        ++ lib.optionals (binding.action != null) (
          if !(builtins.hasAttr binding.action session.actions) then
            [ "Unknown session action: ${binding.action}." ]
          else
            let
              action = session.actions.${binding.action};
            in
            lib.optional (
              action.${backend} == null && action.argv == [ ]
            ) "Session action ${binding.action} has no implementation for ${backend}."
        );
      modeErrors =
        mode:
        let
          grouped = lib.groupBy bindingKey (session.common ++ session.bindings.${mode});
          duplicates = builtins.attrNames (lib.filterAttrs (_: values: builtins.length values > 1) grouped);
        in
        lib.optional (
          mode == "common" || builtins.match "[a-zA-Z][a-zA-Z0-9_-]*" mode == null
        ) "Invalid session mode name: ${mode}; common is reserved for session.common."
        ++ map (key: "Duplicate binding in mode ${mode}: ${key}.") duplicates;
    in
    lib.concatMap bindingErrors bindings
    ++ lib.concatMap modeErrors modes
    ++ lib.optional (lib.any (
      argv: argv == [ ]
    ) session.autostart) "Session autostart commands must contain an executable.";

  assertValid =
    backend: session: value:
    let
      failures = errors backend session;
    in
    if failures == [ ] then
      value
    else
      throw ("Invalid session bindings:\n" + lib.concatStringsSep "\n" failures);
in
{
  flake.lib.session = {
    inherit errors assertValid;
    command =
      backend: session: binding:
      if binding.switchTo != null then
        if backend == "mango" then "setkeymode,${binding.switchTo}" else "mode \"${binding.switchTo}\""
      else
        let
          action = session.actions.${binding.action};
        in
        if action.${backend} != null then
          action.${backend}
        else
          (if backend == "mango" then "spawn," else "exec ") + lib.escapeShellArgs action.argv;
  };
}
