{
  description = "NixOS Configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: let
    lib = import ./lib {inherit inputs;};
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = inputs.nixpkgs.lib.flatten [
        (lib.import-tree ./modules)
        (lib.import-nixos ./modules/hosts)

        inputs.flake-parts.flakeModules.modules
        inputs.home-manager.flakeModules.home-manager
      ];
    };
}
