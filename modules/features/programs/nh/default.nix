{
  flake.modules.homeManager.nh = {config, ...}: {
    programs.nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/.nixdots";

      clean = {
        enable = true;
        extraArgs = "--keep 1";
      };
    };
  };
}
