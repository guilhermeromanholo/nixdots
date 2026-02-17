{self, ...}: {
  flake.modules.nixos.vm = {
    imports = with self.modules.nixos; [
      # Bundles
      base

      # Services
      audio
      openssh
    ];

    settings = {
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

    users.users.guilherme = {
      isNormalUser = true;
      description = "guilherme";
      extraGroups = ["networkmanager" "wheel"];
    };

    system.stateVersion = "25.11";
  };
}
