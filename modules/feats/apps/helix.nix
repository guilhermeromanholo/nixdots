{self, ...}: {
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ty
      nixd
      helix
    ];
  };

  flake.modules.hjem.helix.files = with self.lib; {
    ".config/helix/config.toml".source = linkDots "helix/config.toml";
    ".config/helix/languages.toml".source = linkDots "helix/languages.toml";
  };
}
