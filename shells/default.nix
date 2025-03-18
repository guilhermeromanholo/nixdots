{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];

  perSystem = {pkgs, ...}: {
    devshells = {
      java = import ./java.nix {inherit pkgs;};
      poetry = import ./poetry.nix {inherit pkgs;};
    };
  };
}
