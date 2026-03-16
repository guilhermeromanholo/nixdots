{lib, ...}: {
  flake.modules.nixos.testvm = {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
