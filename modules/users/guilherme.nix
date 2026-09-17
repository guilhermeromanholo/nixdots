{self, ...}: {
  flake.modules.nixos.guilherme = {
    self',
    config,
    ...
  }: {
    imports = with self.modules.nixos; [
      fish
      helix
    ];

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
