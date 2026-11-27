{inputs, ...}: {
  imports = [
    inputs.wrappers.flakeModules.default
    inputs.flake-parts.flakeModules.modules
  ];

  systems = [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ];
}
