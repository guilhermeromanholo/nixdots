{ lib, ... }:
{
  flake.nixosModules.noctalia = { pkgs, ... }: {
    key = "nixdots:modules/desktop/noctalia/default.nix:noctalia";
    environment.systemPackages = [ pkgs.my.noctalia ];
    session.autostart = [ [ (lib.getExe pkgs.my.noctalia) ] ];
    session.actions = {
      "launcher.open".argv = [
        (lib.getExe pkgs.my.noctalia)
        "msg"
        "panel-toggle"
        "launcher"
      ];
      "session.lock".argv = [
        (lib.getExe pkgs.my.noctalia)
        "msg"
        "session"
        "lock"
      ];
      "screenshot.region".argv = [
        (lib.getExe pkgs.my.noctalia)
        "msg"
        "screenshot-region"
      ];
    };
  };
}
