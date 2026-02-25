{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = with self.modules.nixos; [
      system-desktop
    ];

    users.users.guilherme = {
      isNormalUser = true;
      description = "guilherme";
      initialPassword = "password";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
