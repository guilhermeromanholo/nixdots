{inputs, ...}: {
  imports = [
    inputs.wrappers.flakeModules.wrappers
  ];

  systems = [
    "x86_64-linux"
  ];
}
