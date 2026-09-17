{inputs, ...}: {
  flake.modules.nixos.fish = {pkgs, ...}: {
    programs.fish = {
      enable = true;
      package = inputs.wrappers.wrappers.fish.wrap {
        inherit pkgs;
        configFile.path = ./config.fish;
      };
    };

    environment.systemPackages = with pkgs; [
      eza
      zoxide
    ];
  };
}
