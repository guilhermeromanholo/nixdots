{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;
in {
  # Import Modules
  import-tree = path:
    lib.fileset.toList (lib.fileset.fileFilter (file: file.hasExt "nix") path);

  # Make NixOS Configurations
  import-nixos = path: {
    flake.nixosConfigurations = lib.mapAttrs (
      name: _:
        lib.nixosSystem {
          modules = [inputs.self.modules.nixos.${name}];
        }
    ) (lib.readDir path);
  };
}
