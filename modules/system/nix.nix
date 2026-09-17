{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.nix = {
    nix = {
      settings = {
        flake-registry = "";
        trusted-users = ["@wheel"];
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
      };

      optimise.automatic = true;

      gc = {
        automatic = true;
        randomizedDelaySec = "24h";
        options = "--delete-older-than 3d";
      };

      registry =
        lib.mapAttrs (_: flake: {inherit flake;})
        (lib.filterAttrs (_: lib.isType "flake") inputs);
    };
  };
}
