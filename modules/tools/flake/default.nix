{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  config = {
    systems = [
      "x86_64-linux"
    ];
  };
}
