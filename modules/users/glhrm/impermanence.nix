{
  flake.modules.homeManager.impermanence = {
    home.persistence."/persist" = {
      directories = [
        ".ssh"

        "Github"
        "Documents"
      ];
    };
  };
}
