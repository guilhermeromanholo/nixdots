{ lib, ... }:
let
  bind = modifiers: key: action: { inherit modifiers key action; };
  directionKeys = {
    h = "left";
    l = "right";
    k = "up";
    j = "down";
  };
in
{
  flake.nixosModules.session-bindings.key = "nixdots:modules/desktop/session/bindings.nix:session-bindings";
  flake.nixosModules.session-bindings.session = {
    commonBindings = [ (bind [ "SUPER" ] "r" "config.reload") ];

    bindings.default = [
      (bind [ "SUPER" ] "q" "window.close")
      (bind [ "SUPER" ] "Return" "terminal.open")
      (bind [ "SUPER" ] "d" "launcher.open")
      (bind [ "CTRL" "ALT" ] "l" "session.lock")
      (bind [ "SUPER" ] "p" "screenshot.region")
      {
        modifiers = [
          "SUPER"
          "SHIFT"
        ];
        key = "r";
        switchTo = "resize";
      }
    ]
    ++ lib.mapAttrsToList (key: direction: bind [ "SUPER" ] key "focus.${direction}") directionKeys
    ++ lib.concatMap (
      number:
      let
        tag = toString number;
      in
      [
        (bind [ "SUPER" ] tag "workspace.${tag}")
        (bind [ "SUPER" "SHIFT" ] tag "workspace.move.${tag}")
      ]
    ) (lib.range 0 9);

    bindings.resize =
      lib.mapAttrsToList (key: direction: bind [ ] key "resize.${direction}") directionKeys
      ++ [
        {
          key = "Escape";
          switchTo = "default";
        }
        {
          key = "Return";
          switchTo = "default";
        }
      ];
  };
}
