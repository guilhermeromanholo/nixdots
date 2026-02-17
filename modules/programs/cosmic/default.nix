{
  flake.modules.nixos.cosmic = {pkgs, ...}: {
    services.desktopManager.cosmic.enable = true;

    environment.cosmic.excludePackages = with pkgs; [
      cosmic-edit
      cosmic-player
    ];
  };
}
