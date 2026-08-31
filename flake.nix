{
  description = "NixOS Configurations";

  inputs = {
    # Dendritic
    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Treefmt
    treefmt-nix.url = "github:numtide/treefmt-nix";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Hjem
    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";

    # Disko
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Theming
    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes.url = "github:tinted-theming/schemes";
    tt-schemes.flake = false;

    tt-helix.url = "github:tinted-theming/tinted-helix";
    tt-helix.flake = false;
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);
}
