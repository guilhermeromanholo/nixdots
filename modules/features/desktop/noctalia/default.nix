{inputs, ...}: {
  flake.modules.homeManager.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell.enable = true;
    programs.noctalia-shell.settings.location.autoLocate = true;
  };
}
