{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.helix = {pkgs, ...}: {
    environment.systemPackages = [
      (inputs.wrappers.wrappers.helix.wrap {
        inherit pkgs;
        settings = lib.importTOML ./config.toml;
        languages = lib.importTOML ./languages.toml;
      })
    ];
  };
}
