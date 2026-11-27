{self, ...}: {
  flake.modules.nixos.nix = self.lib.mkModule {
    nix.settings = {
      # Optimise store creating hard
      # links for identical contents
      auto-optimise-store = true;

      # Allow wheel users to access
      # nix daemon
      trusted-users = ["@wheel"];

      # Enable flakes
      # Enable nix-command for nix run, ...
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };

    # Automatically run the optimiser
    nix.optimise.automatic = true;

    # Garbage collector for older
    # generations
    nix.gc = {
      automatic = true;
      randomizedDelaySec = "24h";
      options = "--delete-older-than 3d";
    };
  };
}
