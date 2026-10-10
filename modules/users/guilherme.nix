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
        ];

        isNormalUser = true;
        initialPassword = "password";
      }
    );

    persist.users.guilherme.directories = [
      ".ssh"
      ".nixdots"
      "Github"
      "Documents"
    ];
  };
}
