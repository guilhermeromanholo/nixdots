{inputs, ...}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
  ];

  flake.lib = {
    mkIfPersistence = config: settings:
      if config.environment ? persistence
      then {persistence."/persist" = settings;}
      else {};

    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;

    applyTheme = config: app:
      config.scheme {
        template = builtins.readFile "${inputs.dots}/${app}/base16.mustache";
      };
  };
}
