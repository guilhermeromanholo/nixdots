{
  flake.nixosModules.openssh = {
    key = "nixdots:modules/system/openssh.nix:openssh";
    services.openssh = {
      enable = true;

      settings.PermitRootLogin = "no";
      settings.PasswordAuthentication = true;
    };

    persist.root.directories = [ "/etc/ssh" ];
    persist.user.directories = [ ".ssh" ];
  };
}
