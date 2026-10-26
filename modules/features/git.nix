{ self, ... }: {
  flake.wrappers.git = { wlib, ... }: {
    imports = [
      wlib.wrapperModules.git
      self.modules.generic.wrapper-theme
    ];
    # Retain the pre-migration identity, signing and includes until the user
    # chooses to make them declarative. No name/email is guessed here.
    settings.include.path = "~/.gitconfig";
  };
  flake.modules.nixos.git = { config, pkgs, ... }: {
    users.users.${config.nixdots.user.name}.packages = [ pkgs.nixdots.git ];
  };
}
