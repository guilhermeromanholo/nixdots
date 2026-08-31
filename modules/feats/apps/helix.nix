{
  self,
  inputs,
  ...
}: {
  flake.modules.nixos.helix = {pkgs, ...}: {
    imports = with self.modules.nixos; [
      theme
    ];

    environment.systemPackages = with pkgs; [
      ty
      nixd
      helix
    ];
  };

  flake.modules.hjem.helix = {osConfig, ...}: {
    files = with self.lib; {
      ".config/helix/languages.toml".source = linkDots "helix/languages.toml";

      ".config/helix/config.toml".text = ''
        theme = "tinted"
        ${builtins.readFile (linkDots "helix/config.toml")}
      '';

      ".config/helix/themes/tinted.toml".source = osConfig.scheme {
        target = "base16";
        templateRepo = inputs.tt-helix;
      };
    };
  };
}
