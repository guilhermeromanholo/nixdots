{
  flake.modules.nixos.persistence-contract = { lib, ... }: {
    key = "nixdots:persistence-contract";
    options.nixdots.persistence = {
      enable = lib.mkEnableOption "persistência do sistema e usuário";
      root = lib.mkOption {
        type = lib.types.strMatching "/.*";
        default = "/persist";
        description = "Raiz já existente da persistência.";
      };
      systemDirectories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Diretórios adicionais do sistema.";
      };
      userDirectories = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Diretórios relativos ao home que precisam sobreviver ao reboot.";
      };
      userFiles = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Arquivos relativos ao home que precisam sobreviver ao reboot.";
      };
    };
  };
}
