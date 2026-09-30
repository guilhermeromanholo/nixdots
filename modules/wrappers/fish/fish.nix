{
  flake.wrappers.fish = {
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.wrapperModules.fish];

    runtimePkgs = with pkgs; [
      eza
      zoxide
    ];

    configFile.path = ./config.fish;
  };
}
