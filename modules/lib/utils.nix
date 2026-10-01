{inputs, ...}: {
  flake.lib = {
    mkIfPersistence = config: settings:
      if config.environment ? persistence
      then {persistence."/persist" = settings;}
      else {};

    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;

    applyTheme = path: pkgs: let
      base16Lib = pkgs.callPackage inputs.base16.lib {};
      scheme = base16Lib.mkSchemeAttrs inputs.self.theme.scheme;
    in
      scheme {template = builtins.readFile path;};
  };
}
