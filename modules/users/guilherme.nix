{ self, moduleWithSystem, ... }:
{
  flake.aspects.guilherme = {
    includes = with self; [
      (lib.forward.user "guilherme")
    ];

    user = moduleWithSystem (
      { self' }: {
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
  };
}
