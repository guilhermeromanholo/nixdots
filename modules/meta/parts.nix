{ inputs, lib, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-aspects.flakeModule
  ];

  systems = [ "x86_64-linux" ];

  perSystem.treefmt.programs = {
    nixfmt.enable = true;
    deadnix.enable = true;
  };

  flake.nixosConfigurations = lib.mapAttrs (
    host: _:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        { networking.hostName = host; }
        inputs.self.modules.nixos.${host}
      ];
    }
  ) (builtins.readDir (inputs.self + /modules/hosts));
}
