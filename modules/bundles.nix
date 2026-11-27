{self, ...}:
{
  flake.nixosModules = with self.nixosModules; {
    base.imports = [
    nix
    users
    locale
    nixpkgs
    user-options
    theme-options
    persist-options
    session-options
    ];

  laptop.imports = [
    workstation
    power
    bluetooth
  ];

    mango-noctaliaimports =  [
      mango
      noctalia
      kitty
    ];

    sway-waybar.imports = [
      sway
      waybar
      kitty
    ];

  workstation.imports =  [
    base
    boot
    audio
    theme
    networking
    openssh
    tailscale
    zsh
    helix
    kitty
    session-bindings
    greeter
  ];
  };
}
