{
  flake.modules.nixos.sddm = {pkgs, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      theme = "sddm-astronaut-theme";
      settings = {Theme = {Current = "sddm-astronaut-theme";};};

      extraPackages = with pkgs; [
        (sddm-astronaut.override {
          embeddedTheme = "astronaut";
        })
      ];
    };
  };
}
