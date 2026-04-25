{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;

      settings.alias = {
        st = "status";
        cm = "commit";
        ck = "checkout";
        undo = "reset HEAD~1 --mixed";
        unstage = "reset HEAD --";
      };
    };
  };
}
