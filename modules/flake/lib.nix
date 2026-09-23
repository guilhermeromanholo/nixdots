{inputs, ...}: {
  flake.lib = {
    applyTheme = path: pkgs: let
      base16Lib = pkgs.callPackage inputs.base16.lib {};
      scheme = base16Lib.mkSchemeAttrs inputs.self.theme;
    in
      scheme { template = builtins.readFile path; };
  };
}
