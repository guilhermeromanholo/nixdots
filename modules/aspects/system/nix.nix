{
  den.aspects.nix.nixos = {
    nix = {
      settings = {
        trusted-users = [ "@wheel" ];
        auto-optimise-store = true;
        experimental-features = [ "nix-command flakes" ];
      };

      optimise.automatic = true;

      gc = {
        automatic = true;
        randomizedDelaySec = "24h";
        options = "--delete-older-than 3d";
      };
    };
  };
}
