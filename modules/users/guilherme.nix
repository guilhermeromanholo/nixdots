{self, ...}: {
  flake.modules.nixos.guilherme = {
    pkgs,
    config,
    ...
  }: {
    imports = with self.modules.nixos; [
      fish
    ];

    users.users.guilherme = {
      shell = pkgs.fish;
      isNormalUser = true;

      extraGroups = self.lib.ifGroupExists config [
        "wheel"
        "networkmanager"
      ];

      initialPassword = "password";
    };
  };
}
