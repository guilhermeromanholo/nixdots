{
  flake.modules.nixos.sddm = {pkgs, ...}: {
    services.displayManager.sddm = {
      enable = true;
      theme = "sddm-astronaut-theme";
      settings = {Theme = {Current = "sddm-astronaut-theme";};};
    };

    environment.systemPackages = with pkgs; [
      (sddm-astronaut.override {
        embeddedTheme = "astronaut";
      })
    ];
  };
}
