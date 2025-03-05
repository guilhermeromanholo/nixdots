{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.impermanence;
in {
  imports = [
    ../shared
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  config = lib.mkIf cfg.enable {
    home.persistence."${cfg.persistPath}/home/${config.home.username}" = {
      allowOther = true;

      directories =
        [
          ".nixdots"
          ".ssh"
        ]
        ++ cfg.directories;

      files = cfg.files;
    };
  };
}
