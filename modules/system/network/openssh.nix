{
  flake.nixosModules.network = {
    services.openssh = {
      enable = true;

      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    persist.user.directories = [ ".ssh" ];
  };
}
