{self, ...}: {
  config.flake.factory.user = {
    name,
    admin,
    shell,
  }: {
    nixos.${name} = {pkgs, ...}: {
      users.mutableUsers = false;

      users.users.${name} = {
        isNormalUser = true;
        home = "/home/${name}";

        shell = pkgs.${shell};
        ignoreShellProgramCheck = true;

        extraGroups =
          if admin
          then ["wheel" "networkmanager"]
          else [];
      };

      home-manager.users.${name} = {
        imports = [self.modules.homeManager.${name}];
      };
    };

    homeManager.${name} = {
      home = {
        username = name;
        homeDirectory = "/home/${name}";
      };
    };
  };
}
