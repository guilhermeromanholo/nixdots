{lib, ...}: {
  options.modules.gnome = {
    # Keyboard
    xkb = {
      layout = lib.mkOption {
        type = lib.types.str;
        default = "br";
      };

      variant = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
    };
  };
}
