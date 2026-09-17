{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-parts.flakeModules.modules
  ];

  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = {};
  };

  config = {
    systems = [
      "x86_64-linux"
    ];

    perSystem.treefmt.programs = {
      taplo.enable = true; # TOML
      alejandra.enable = true; # Nix
    };

    flake.nixosConfigurations = lib.mapAttrs (
      name: _:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            {networking.hostName = name;}
            inputs.self.modules.nixos.${name}
          ];
        }
    ) (builtins.readDir ./hosts);
  };
}
