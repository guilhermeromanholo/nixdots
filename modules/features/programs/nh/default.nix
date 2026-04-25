{
  flake.modules.homeManager.nh = {config, ...}: {
    programs.nh = {
      enable = true;
      clean.enable = true;
      flake = "${config.home.homeDirectory}/.nixdots";
    };
  };
}
