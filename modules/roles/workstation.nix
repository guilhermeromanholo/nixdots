{ self, ... }:
{
  flake.nixosModules.workstation.key = "nixdots:modules/roles/workstation.nix:workstation";
  flake.nixosModules.workstation.imports = with self.nixosModules; [
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
}
