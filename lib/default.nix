{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;
in {
  # Import modules
  import-tree = path:
    lib.fileset.toList (lib.fileset.fileFilter (file: file.hasExt "nix") path);

  # Make NixOS configuration
  mkNixos = name: {
    ${name} = inputs.nixpkgs.lib.nixosSystem {
      modules = [inputs.self.modules.nixos.${name}];
    };
  };
}
