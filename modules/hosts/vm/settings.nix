{
  flake.modules.nixos.vm = {
    settings = {
      hostname = "vm";

      locale = "pt_BR.UTF-8";
      timezone = "America/Sao_Paulo";

      uefi = false;
      osProber = false;
      bootDevice = "/dev/vda";
    };

    system.stateVersion = "25.11";
  };
}
