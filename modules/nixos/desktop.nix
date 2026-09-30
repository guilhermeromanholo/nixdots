{self, ...}: {
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.base
    ];

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Audio
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Security
    security.rtkit.enable = true;
    security.polkit.enable = true;

    # Desktop
    programs.mango.enable = true;
    services.displayManager.sddm.enable = true;
  };
}
