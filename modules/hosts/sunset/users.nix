{self, ...}: {
  flake.modules.nixos.sunset = {
    imports = with self.modules.nixos; [
      glhrm
    ];

    home-manager.users.glhrm = {
      imports = with self.modules.homeManager; [
        firefox
      ];
    };
  };
}
