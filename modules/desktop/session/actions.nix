{ lib, ... }:
let
  directions = [
    "left"
    "right"
    "up"
    "down"
  ];
  resize = {
    left = {
      mango = "resizewin,-10,0";
      sway = "resize shrink width 10 px";
    };
    right = {
      mango = "resizewin,10,0";
      sway = "resize grow width 10 px";
    };
    up = {
      mango = "resizewin,0,-10";
      sway = "resize shrink height 10 px";
    };
    down = {
      mango = "resizewin,0,10";
      sway = "resize grow height 10 px";
    };
  };
in
{
  flake.nixosModules.session-bindings.key = "nixdots:modules/desktop/session/actions.nix:session-bindings";
  flake.nixosModules.session-bindings.session.actions = {
    "window.close" = {
      mango = "killclient";
      sway = "kill";
    };
    "config.reload" = {
      mango = "reload_config";
      sway = "reload";
    };
  }
  // lib.genAttrs (map (direction: "focus.${direction}") directions) (
    name:
    let
      direction = lib.removePrefix "focus." name;
    in
    {
      mango = "focusdir,${direction}";
      sway = "focus ${direction}";
    }
  )
  // lib.mapAttrs' (direction: value: lib.nameValuePair "resize.${direction}" value) resize
  // lib.listToAttrs (
    lib.concatMap (
      number:
      let
        tag = toString number;
      in
      [
        (lib.nameValuePair "workspace.${tag}" {
          mango = "view,${tag}";
          sway = "workspace number ${tag}";
        })
        (lib.nameValuePair "workspace.move.${tag}" {
          mango = "tag,${tag}";
          sway = "move container to workspace number ${tag}";
        })
      ]
    ) (lib.range 0 9)
  );
}
