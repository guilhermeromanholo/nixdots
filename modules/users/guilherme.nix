{self, ...}: {
  flake.nixosModules.guilherme = {
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

      packages = [
        self'.packages.helix
      ];

      isNormalUser = true;
      initialPassword = "password";
    };
  };
}
