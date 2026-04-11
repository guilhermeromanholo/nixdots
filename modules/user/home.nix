{self, ...}: let
  name = "glhrm";
in {
  flake.modules.homeManager.${name} = {
    homeManager.${name} = {
      imports = with self.modules.homeManager; [
        # ...
      ];

      home = {
        username = name;
        homeDirectory = "/home/${name}";
      };
    };
  };
}
