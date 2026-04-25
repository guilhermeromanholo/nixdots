{self, ...}: let
  name = "glhrm";
in {
  flake.modules.nixos.${name} = {config, ...}: {
    imports = [
      self.inputs.agenix.nixosModules.default
    ];

    users.mutableUsers = false;

    users.users.${name} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      hashedPasswordFile = config.age.secrets.glhrm-pass.path;
    };

    age.identityPaths = [ "/home/glhrm/.ssh/id_rsa" ];
    age.secrets.glhrm-pass.file = self + /secrets/glhrm-pass.age;

    home-manager.users.${name} = {
      imports = [self.modules.homeManager.${name}];
    };
  };
}
