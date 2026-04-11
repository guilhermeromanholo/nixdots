{
  flake.modules.nixos.ly = {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        bigclock = "en";
        bigclock_12hr = true;
        box_title = "Welcome to NixOS!";
        hide_version_string = true;
        text_in_center = true;
        vi_mode = true;
        vi_default_mode = "insert";
        xinitrc = "null";
      };
    };
  };
}
