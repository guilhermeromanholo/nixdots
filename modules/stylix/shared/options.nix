{lib, ...}: {
  options.modules.stylix = {
    enable = lib.mkEnableOption "Stylix";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "gruvbox";
    };
  };
}
