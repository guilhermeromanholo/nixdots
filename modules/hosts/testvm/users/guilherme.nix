{self, ...}: {
  flake.modules.nixos.testvm = {
    imports = with self.modules.nixos; [
      guilherme
    ];

    home-manager.users.guilherme = {
      # ...
    };
  };
}
