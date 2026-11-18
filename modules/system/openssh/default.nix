{
  flake.nixosModules.openssh = {
    services.openssh = {
      enable = true;

      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    persist.user.directories = [ ".ssh" ];
  };
}
