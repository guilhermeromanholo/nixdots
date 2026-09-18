{self, ...}: {
  configurations.nixos.vortex = {
    system = "x86_64-linux";
    version = "26.11";

    module = {
      imports = with self.modules.nixos; [
        # Role
        cli

        # Tools
        wsl

        # Users
        guilherme
      ];

      wsl.defaultUser = "guilherme";
    };
  };
}
