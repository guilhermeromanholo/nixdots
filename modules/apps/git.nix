{
  flake.wrappers.git = {wlib, ...}: {
    imports = [wlib.wrapperModules.git];

    settings.alias = {
      s = "status";
      br = "brach";
      cm = "commit";
      ck = "checkout";
      unstage = "reset HEAD --";
    };
  };
}
