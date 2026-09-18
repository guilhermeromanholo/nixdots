{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.fish = inputs.wrappers.wrappers.fish.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        eza
        zoxide
      ];

      configFile.path = ./config.fish;
    };
  };
}
