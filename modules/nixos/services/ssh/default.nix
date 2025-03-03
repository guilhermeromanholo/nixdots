{
  lib,
  config,
  ...
}: let
  cfg = config.modules.services.ssh;
in {
  options.modules.services.ssh = {
    enable = lib.mkEnableOption "Ssh";
    passwordAuth = lib.mkEnableOption "Ssh Password Auth";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = cfg.passwordAuth;
      };
    };
  };
}
