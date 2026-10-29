{
  den.aspects.system.nix = {
    nixos.nix = {
      settings = {
        auto-optimise-store = true;

        trusted-users = [ "@wheel" ];

        experimental-features = [
          "flakes"
          "nix-command"
        ];
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
