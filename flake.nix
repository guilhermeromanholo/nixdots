{
  description = "NixOS Configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    flake-file.url = "github:vic/flake-file";
    import-tree.url = "github:vic/import-tree";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [(inputs.import-tree ./modules)];
    };
}
