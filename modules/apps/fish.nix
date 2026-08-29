{self, ...}: {
  flake.modules.nixos.fish = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      package = self.wrappers.fish.wrap {inherit pkgs;};
    };

    environment.systemPackages = with pkgs; [
      eza
      zoxide
    ];
  };

  flake.wrappers.fish = {wlib, ...}: {
    imports = [wlib.wrapperModules.fish];

    flags."--no-config" = false;

    configFile.content = ''
      ${builtins.readFile (self.lib.linkDots "fish/config.fish")}
    '';
  };
}
