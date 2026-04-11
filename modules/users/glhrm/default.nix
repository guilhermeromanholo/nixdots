{self, ...}: let
  name = "glhrm";
in {
  flake.homeConfigurations = self.lib.mkHomeManager name "x86_64-linux";

  flake.modules = {
    nixos.${name} = {
      users.users.${name} = {
        isNormalUser = true;
        initialPassword = "password";
        extraGroups = ["wheel" "networkmanager"];
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
