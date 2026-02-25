{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = with self.modules.nixos; [
      system-desktop
      tuigreet
    ];

    users.users.guilherme = {
      isNormalUser = true;
      description = "guilherme";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
