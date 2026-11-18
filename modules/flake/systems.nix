{ inputs, ... }:
{
  imports = [
    inputs.wrappers.flakeModules.default
  ];

  systems = [ "x86_64-linux" ];
}
