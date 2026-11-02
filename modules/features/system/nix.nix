{
  flake.modules.nixos.nix = {
    nix = {
      settings = {
        # Optimise store creating hard
        # links for identical contents
        auto-optimise-store = true;

        # Allow wheel users to access
        # nix daemon
        trusted-users = [ "@wheel" ];

        # Enable flakes
        # Enable nix-command for nix run, ...
        experimental-features = [
          "flakes"
          "nix-command"
        ];
      };

      # Automatically run the optimiser
      optimise.automatic = true;

      # Garbage collector for older
      # generations
      gc = {
        automatic = true;
        randomizedDelaySec = "24h";
        options = "--delete-older-than 3d";
      };
    };
  };
}
