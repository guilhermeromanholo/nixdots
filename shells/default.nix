{inputs, ...}: {
  imports = [
    inputs.devshell.flakeModule
  ];
  perSystem = {pkgs, ...}: {
    devshells.poetry = import ./poetry.nix {inherit pkgs;};
  };
}
