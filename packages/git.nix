{
  inputs,
  pkgs,
  ...
}:
inputs.wrappers.wrappers.git.wrap {
  inherit pkgs;

  settings.alias = {
    s = "status";
    br = "brach";
    cm = "commit";
    ck = "checkout";
    unstage = "reset HEAD --";
  };
}
