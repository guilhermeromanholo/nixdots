{self, ...}: {
  configurations.nixos.vortex = {
    version = "26.11";
    system = "x86_64-linux";
    username = "guilherme";

    module = {
      imports = with self.modules.nixos; [
        base
        wsl
      ];

      wsl.defaultUser = "guilherme";
    };
  };
}
