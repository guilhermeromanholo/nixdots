{
  flake.modules.nixos.sddm = {pkgs, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "silent";

      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
      ];
    };

    environment.systemPackages = with pkgs; [
      sddm-silent
    ];
  };
}
