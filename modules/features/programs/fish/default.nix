{
  flake.modules.homeManager.fish = {config, ...}: {
    programs.fish = {
      enable = true;
    };
  };
}
