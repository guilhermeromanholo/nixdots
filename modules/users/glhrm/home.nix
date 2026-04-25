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

    programs.git = {
      enable = true;

      settings = {
        user.name = "guilhermeromanholo";
        user.email = "guilhermeromanholo@users.noreply.github.com";
      };
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
