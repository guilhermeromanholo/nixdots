{
  flake.modules.homeManager.niri = {
    programs.niri.settings.input = {
      keyboard = {
        xkb.layout = "br";
      };

      mouse = {
        enable = true;
        natural-scroll = false;
      };

      touchpad = {
        enable = true;
        natural-scroll = false;
      };
    };
  };
}
