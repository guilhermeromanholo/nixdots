{ lib, ... }:
let
  paths =
    description:
    lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      apply = lib.unique;
      inherit description;
    };
in
{
  flake.nixosModules.persist-options.key = "nixdots:modules/system/persistence/schema.nix:persist-options";
  flake.nixosModules.persist-options.options.persist = {
    storagePath = lib.mkOption {
      type = lib.types.strMatching "/.+";
      default = "/persist";
      description = "Persistent storage root; consumed only by the impermanence module.";
    };
    root.files = paths "Absolute system file paths to persist.";
    root.directories = paths "Absolute system directory paths to persist.";
    user.files = paths "Files to persist, relative to the primary user's home.";
    user.directories = paths "Directories to persist, relative to the primary user's home.";
  };
}
