{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;
in {
  # Import modules
  import-tree = path:
    lib.fileset.toList (lib.fileset.fileFilter (file: file.hasExt "nix") path);

  # NixOS options
  mkOpt = type: default:
    lib.mkOption {
      inherit default;
      type = lib.types.${type};
    };

  # Make NixOS configuration
  mkNixos = name: {
    ${name} = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.self.modules.nixos.${name}
      ];
    };
  };

  # Check if home-manager is enabled
  mkIfHomeManager = {
    config,
    settings,
  }:
    if (config ? homeManager)
    then settings
    else {};
}
