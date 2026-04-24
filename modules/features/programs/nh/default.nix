{
  flake.modules.homeManager.nh = {config, ...}: {
    programs.nh = {
      enable = true;
      clean.enable = true;
    };

    environment.sessionVariables = {
      NH_FLAKE = "${config.home.homeDirectory}/.nixdots";
    };
  };

  flake.modules.homeManager.impermanence = {
    home.persistence."/persist" = {
      directories = [
        ".nixdots"
      ];
    };
  };
}
