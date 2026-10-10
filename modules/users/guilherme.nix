{ self, moduleWithSystem, ... }:
{
  flake.aspects.guilherme = {
    includes = with self; [
      (lib.forward.user "guilherme")
    ];

    user = moduleWithSystem (
      { self' }: {
        shell = self'.packages.fish;

        extraGroups = [
          "wheel"
          "networkmanager"
        ];

        packages = [
          self'.packages.helix

          (self'.packages.git.wrap {
            settings.user.name = "guilhermeromanholo";
            settings.user.email = "89668419+guilhermeromanholo@users.noreply.github.com";
          })
        ];

        isNormalUser = true;
        initialPassword = "password";
      }
    );

    persist.users.guilherme.directories = [
      "Github"
      "Documents"

      ".ssh"
      ".nixdots"
      ".config/zen"
    ];
  };
}
