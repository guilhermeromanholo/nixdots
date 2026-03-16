{self, ...}: {
  config.flake.factory.user = name: {
    nixos.${name} = {
      users.users.${name} = {
        isNormalUser = true;
        home = "/home/${name}";
        initialPassword = "password";
      };

      home-manager.users.${name} = {
        imports = [self.modules.homeManager.${name}];
      };
    };

    homeManager = {
      home = {
        username = name;
        homeDirectory = "/home/${name}";
      };
    };
  };
}
