{ self, moduleWithSystem, ... }:
{
  flake.aspects.desktop = {
    includes = with self.aspects; [
      base
      boot
      audio
      greeter
      firmware
    ];

    nixos = moduleWithSystem (
      { self', pkgs }: {
        programs.mango = {
          enable = true;
          package = self'.packages.mango;
        };

        fonts.packages = with pkgs; [
          nerd-fonts.jetbrains-mono
        ];
      }
    );
  };
}
