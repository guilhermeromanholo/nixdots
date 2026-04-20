{
  flake.modules.nixos.sunset = {lib, ...}: {
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
