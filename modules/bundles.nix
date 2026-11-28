{ self, ... }:
{
  flake.modules.nixos = with self.modules.nixos; {
    base.imports = [
      nix
      users
      locale
      options
      networking
    ];

    desktop.imports = [
      base
      boot
      audio
    ];

    laptop.imports = [
      desktop
    ];
  };
}
