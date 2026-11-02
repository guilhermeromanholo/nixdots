{ lib, ... }:
{
  flake.lib = rec {
    # Helper to check if impermanence
    # is enabled
    mkIfPersistence =
      {
        config,
        users ? { },
        files ? [ ],
        directories ? [ ],
      }:
      (
        if config.environment ? persistence then
          { persistence = { inherit users files directories; }; }
        else
          { }
      );

    mkIfUserPersistence =
      {
        config,
        files ? [ ],
        directories ? [ ],
      }:
      let
        users = lib.filterAttrs (_: user: user.isNormalUser) config.users.users;
      in
      mkIfPersistence {
        inherit config;
        users = lib.mapAttrs (_: _: { inherit directories files; }) users;
      };
  };
}
