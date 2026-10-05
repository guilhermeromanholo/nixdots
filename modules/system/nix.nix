{
  flake.modules.nixos.nix = {
    # Nix Settings
    nix.settings = {
      trusted-users = ["@wheel"];
      auto-optimise-store = true;
      experimental-features = ["nix-command flakes"];
    };

    nix.optimise.automatic = true;

    # Garbage Collector
    nix.gc = {
      automatic = true;
      randomizedDelaySec = "24h";
      options = "--delete-older-than 3d";
    };
  };
}
