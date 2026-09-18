{self, ...}: {
  flake.modules.nixos.guilherme = {
    self',
    config,
    ...
  }: {
    users.users.guilherme = {
      shell = self'.packages.fish;

      extraGroups = self.lib.ifGroupExists config [
        "wheel"
        "networkmanager"
      ];

      isNormalUser = true;
      initialPassword = "password";
    };
  };
}
