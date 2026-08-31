{inputs, ...}: {
  imports = [
    # Modules
    inputs.flake-parts.flakeModules.modules
  ];

  systems = ["x86_64-linux"];
}
