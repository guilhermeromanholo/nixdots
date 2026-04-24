{self, ...}: let
  name = "glhrm";
in {
  flake.homeConfigurations = self.lib.mkHomeManager name "x86_64-linux";

  flake.modules.homeManager.${name} = {
    imports = with self.modules.homeManager; [
      nh
    ];

    home = {
      username = name;
      homeDirectory = "/home/${name}";
    };
  };

  flake.modules.homeManager.impermanence = {
    home.persistence."/persist" = {
      directories = [
        ".ssh"
        "Github"
        "Documents"
      ];
    };
  };
}
