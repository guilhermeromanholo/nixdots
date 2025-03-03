{
  lib,
  config,
  ...
}: let
  cfg = config.modules.system;
in {
  imports = [
    ./hm
    ./nix
    ./boot
    ./users
    ./network
    ./localtime
  ];

  options.modules.system = {
    enable = lib.mkEnableOption "System";
  };

  config = lib.mkIf cfg.enable {
    modules.system = {
      nix.enable = true;
      boot.enable = true;
      network.enable = true;
      localtime.enable = true;
    };
  };
}
