{
  self,
  lib,
  ...
}: {
  flake.modules.nixos.core = {host, ...}: {
    imports = with self.modules.nixos; [
      nix
      user
      locale
      network
      contracts
    ];

    system.stateVersion = host.version;
    nixpkgs.hostPlatform = lib.mkDefault host.arch;
  };
}
