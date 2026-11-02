{ self, ... }:
{
  flake.modules.nixos.openssh = { config, ... }: {
    # Enable openssh service
    services.openssh = {
      enable = true;

      # Block root login and authenticaton
      # without keys
      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    # Persist the directory with users
    # ssh keys
    environment = self.lib.mkIfUserPersistence {
      inherit config;
      directories = [ ".ssh" ];
    };
  };
}
