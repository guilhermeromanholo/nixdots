{
  flake.modules.nixos.user-contract = { config, lib, ... }: {
    key = "nixdots:user-contract";
    options.nixdots.user = {
      name = lib.mkOption {
        type = lib.types.strMatching "[a-z_][a-z0-9_-]*";
        default = "guilherme";
        description = "Usuário principal deste host.";
      };
      home = lib.mkOption {
        type = lib.types.strMatching "/.*";
        default = "/home/${config.nixdots.user.name}";
        description = "Diretório pessoal; manter consistente com o usuário.";
      };
    };
  };
}
