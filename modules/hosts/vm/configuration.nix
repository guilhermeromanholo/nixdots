{self, ...}: {
  flake.modules.nixos.vm = {
    imports = with self.modules.nixos; [
      system
    ];

    constants = {
      hostname = "vm";
      bootDevice = "/dev/vda";

      locale = "pt_BR.UTF-8";
      timezone = "America/Sao_Paulo";
    };

    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "br";
      variant = "";
    };

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users.guilherme = {
      isNormalUser = true;
      description = "guilherme";
      extraGroups = ["networkmanager" "wheel"];
    };

    programs.firefox.enable = true;
    services.openssh.enable = true;

    system.stateVersion = "25.11";
  };
}
