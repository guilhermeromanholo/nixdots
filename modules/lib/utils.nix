{inputs, ...}: {
  flake.lib = {
    # Add a group to user if the group exists
    #  in the configuration
    ifGroupExists = config: groups:
      builtins.filter
      (g: builtins.hasAttr g config.users.groups)
      groups;

    # Apply flake.theme to my custom packages
    # and modules
    applyTheme = path: pkgs: let
      base16Lib = pkgs.callPackage inputs.base16.lib {};
      scheme = base16Lib.mkSchemeAttrs inputs.self.theme;
    in
      scheme {template = builtins.readFile path;};
  };
}
