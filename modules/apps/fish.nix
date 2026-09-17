{inputs, ...}: {
  flake.modules.nixos.fish = {
    self',
    pkgs,
    ...
  }: {
    programs.fish = {
      enable = true;
      package = self'.packages.fish;
    };

    environment.systemPackages = with pkgs; [
      eza
      zoxide
    ];
  };

  flake.wrappers.fish = {wlib, ...}: {
    imports = [wlib.wrapperModules.fish];
    configFile.path = "${inputs.dots}/fish/config.fish";
  };
}
