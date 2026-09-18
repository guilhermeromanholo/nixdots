{self, ...}: {
  configurations.nixos.taz = {
    system = "x86_64-linux";
    version = "26.11";

    module = {
      imports = with self.modules.nixos; [
        # Role
        desktop

	# Tools
	impermanence

        # Users
        guilherme
      ];
    };
  };
}
