{
  flake.modules.homeManager.impermanence = {
    lib,
    config,
    ...
  }: {
    home.persistence."/persist" = lib.mkIf config.programs.firefox.enable {
      directories = [
        ".mozilla"
      ];
    };
  };
}
