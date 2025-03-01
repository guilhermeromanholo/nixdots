{
  parts.nixosConfigurations = {
    # Virtual machine to test
    # NixOS configurations
    vm = {
      system = "x86_64-linux";
      stateVersion = "24.11";
      modules = [./vm];
    };
  };
}
