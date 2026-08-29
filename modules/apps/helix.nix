{self, ...}: {
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # Helix
      (self.wrappers.helix.wrap {inherit pkgs;})
      # LSPs
      ty
      nixd
    ];
  };

  flake.wrappers.helix = {
    wlib,
    pkgs,
    config,
    ...
  }: {
    imports = [wlib.modules.default];

    package = pkgs.helix;

    constructFiles.settings = {
      relPath = "config/helix/config.toml";
      content = builtins.readFile (self.lib.linkDots "helix/config.toml");
    };

    constructFiles.languages = {
      relPath = "config/helix/languages.toml";
      content = builtins.readFile (self.lib.linkDots "helix/languages.toml");
    };

    env.XDG_CONFIG_HOME = "${placeholder config.outputName}/config";
  };
}
