{inputs, ...}: {
  flake.modules.nixos.nix = {
    lib,
    config,
  }: {
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        # Opinionated: disable global registry
        flake-registry = "";
        # Trusted nix users
        trusted-users = ["@wheel"];
        # Remove duplicates in nix store
        auto-optimise-store = true;
        # Workaround for https://github.com/NixOS/nix/issues/9574
        nix-path = config.nix.nixPath;
        # Enable flakes and new 'nix' command
        experimental-features = "nix-command flakes";
      };

      optimise.automatic = true;

      gc = {
        automatic = true;
        randomizedDelaySec = "24h";
        options = "--delete-older-than 3d";
      };

      # Make flake registry and nix path match flake inputs
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    nixpkgs.config.allowUnfree = true;
    documentation.nixos.enable = false;
  };
}
