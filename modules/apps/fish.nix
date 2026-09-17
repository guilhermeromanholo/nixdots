{inputs, ...}: {
  flake.modules.nixos.fish = {self', ...}: {
    programs.fish = {
      enable = true;
      package = self'.packages.fish;
    };
  };

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

    configFile.path = "${inputs.dots}/fish/config.fish";
  };
}
