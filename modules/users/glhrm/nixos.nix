{self, ...}: let
  name = "glhrm";
in {
  flake.modules.nixos.${name} = {
    users.users.${name} = {
      isNormalUser = true;
      initialPassword = "password";
      extraGroups = ["wheel" "networkmanager"];
    };

    home-manager.users.${name} = {
      imports = [self.modules.homeManager.${name}];
    };
  };
}
