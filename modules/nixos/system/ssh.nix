{
  flake.nixosModules.ssh = {
    services.openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };
  };
}
