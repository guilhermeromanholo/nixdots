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

    applyTheme = name: pkgs: let
      base16Lib = pkgs.callPackage inputs.base16.lib {};
      scheme = base16Lib.mkSchemeAttrs inputs.self.theme.colors;
    in
      scheme {
        template =
          builtins.readFile
          (inputs.self + /themes/templates/${name}.mustache);
      };
  };
}
