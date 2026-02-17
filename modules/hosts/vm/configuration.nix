{self, ...}: {
  flake.modules.nixos.vm = {
    imports = with self.modules.nixos; [
      # System
      boot
      locale
      network
      settings

      # Programs
      sway
      cosmic

      # Services
      audio
      openssh
      tuigreet

      # Nix
      nixconfig
      home-manager
    ];

    users.users.guilherme = {
      isNormalUser = true;
      description = "guilherme";
      extraGroups = ["networkmanager" "wheel"];
    };

    home-manager.users.guilherme = {
      home.username = "guilherme";
      home.homeDirectory = "/home/guilherme";
      home.stateVersion = "25.05";

      systemd.user.startServices = "sd-switch";
    };
  };
}
