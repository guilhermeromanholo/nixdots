{inputs, ...}: {
  imports = [
    # Wrappers
    inputs.wrappers.flakeModules.wrappers
    # Modules
    inputs.flake-parts.flakeModules.modules
  ];

  systems = ["x86_64-linux"];
}
