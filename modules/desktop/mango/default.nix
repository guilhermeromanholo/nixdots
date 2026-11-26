{
  flake.nixosModules.mango = { pkgs, ... }: {
    key = "nixdots:modules/desktop/mango/default.nix:mango";
    programs.mango.enable = true;
    programs.mango.package = pkgs.my.mango;
    session.compositor = "mango";
    session.actions = {
      "window.jump".mango = "togglejump";
      "window.cycle".mango = "overcircle,next";
    };
    session.bindings.default = [
      {
        modifiers = [ "SUPER" ];
        key = "w";
        action = "window.jump";
      }
      {
        modifiers = [ "ALT" ];
        key = "Tab";
        action = "window.cycle";
      }
    ];
  };
}
