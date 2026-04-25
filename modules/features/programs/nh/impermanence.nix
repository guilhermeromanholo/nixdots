{
  flake.modules.homeManager.impermanence = {
    home.persistence."/persist" = {
      directories = [
        ".nixdots"
      ];
    };
  };
}
