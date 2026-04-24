{
  description = "NixOS Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Devshells
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    # Nixvim
    nixvim.url = "github:guilhermeromanholo/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Blueprint
    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    # Home-Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nixos Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs:
    inputs.blueprint {
      inherit inputs;
      systems = ["x86_64-linux"];
    };
}
