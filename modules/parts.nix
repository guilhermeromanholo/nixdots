{inputs, ...}: {
  imports = [
    inputs.wrappers.flakeModules.wrappers
    inputs.flake-parts.flakeModules.modules
  ];

  systems = [
    "x86_64-linux"
  ];
}
