{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.system.nix;
in {
  options.modules.system.nix = {
    enable = lib.mkEnableOption "Nix";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      settings = {
        flake-registry = "";
        trusted-users = ["@wheel"];
        auto-optimise-store = true;
        experimental-features = "nix-command flakes";
      };

      channel.enable = false;
      optimise.automatic = true;

      gc = {
        automatic = true;
        randomizedDelaySec = "24h";
        options = "--delete-older-than 3d";
      };

      nixPath = ["nixpkgs=${inputs.nixpkgs}"];

      registry = {
        system.flake = inputs.self;
        nixpkgs.flake = inputs.nixpkgs;
        home-manager.flake = inputs.home-manager;
      };
    };
  };
}
