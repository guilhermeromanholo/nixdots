{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.helix = {self', ...}: {
    environment.systemPackages = [
      self'.packages.helix
    ];
  };

  flake.wrappers.helix = {wlib, ...}: {
    imports = [wlib.wrapperModules.helix];
    settings = lib.importTOML "${inputs.dots}/helix/config.toml";
    languages = lib.importTOML "${inputs.dots}/helix/languages.toml";
  };
}
