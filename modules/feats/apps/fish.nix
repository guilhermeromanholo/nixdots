{self, ...}: {
  flake.modules.nixos.fish = {pkgs, ...}: {
    programs.fish.enable = true;

    environment.systemPackages = with pkgs; [
      eza
      zoxide
    ];
  };

  flake.modules.hjem.fish = with self.lib; {
    files.".config/fish/config.fish".source = linkDots "fish/config.fish";
  };
}
