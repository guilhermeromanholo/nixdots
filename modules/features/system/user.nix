{
  flake.modules.nixos.user = { config, lib, ... }: {
    options.nixdots.user.name = lib.mkOption {
      type = lib.types.strMatching "[a-z_][a-z0-9_-]*";
      default = "guilherme";
      description = "Usuário principal deste host.";
    };
    config.users.users.${config.nixdots.user.name} = {
      isNormalUser = true;
      home = lib.mkDefault "/home/${config.nixdots.user.name}";
      createHome = true;
      extraGroups = [ "wheel" ];
      # Existing credentials are retained; provision access on new machines.
    };
  };
}
