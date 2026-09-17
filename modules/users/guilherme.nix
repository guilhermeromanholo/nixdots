{self, ...}: {
  flake.modules.nixos.guilherme = {pkgs, ...}: {
    imports = with self.modules.nixos; [
      fish
      helix
    ];

    users.users.guilherme = {
      shell = pkgs.fish;

      isNormalUser = true;
      initialPassword = "password";

      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };
}
