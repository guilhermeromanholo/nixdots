{ self, lib, ... }:
let
  schemes = ../../assets/schemes;
  wallpapers = ../../assets/wallpapers;
  files = lib.filterAttrs (name: kind: kind == "regular" && lib.hasSuffix ".toml" name) (
    builtins.readDir schemes
  );
in
{
  options.flake.themes = lib.mkOption {
    type = lib.types.attrsOf self.lib.types.themeType;
    default = { };
    description = "Available themes, loaded from assets/schemes.";
  };

  config.flake.themes = lib.mapAttrs' (
    file: _:
    let
      name = lib.removeSuffix ".toml" file;
    in
    lib.nameValuePair name (
      builtins.fromTOML (builtins.readFile (schemes + "/${file}"))
      // {
        inherit name;
        wallpaper = {
          default = wallpapers + "/${name}/default.jpg";
          directory = wallpapers + "/${name}";
        };
      }
    )
  ) files;
}
