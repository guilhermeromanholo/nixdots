{
  parts.nixosConfigurations = {
    # Tests machine
    vm = {
      system = "x86_64-linux";
      stateVersion = "24.11";
      modules = [./vm];
    };

    # Personal machine
    sunset = {
      system = "x86_64-linux";
      stateVersion = "24.11";
      modules = [./sunset];
    };

    # Work machine
    taz = {
      system = "x86_64-linux";
      stateVersion = "24.11";
      modules = [./taz];
    };
  };
}
