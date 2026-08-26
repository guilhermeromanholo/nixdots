{
  flake.wrappers.zellij = {
    wlib,
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [wlib.modules.default];

    options.settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };

    config.package = pkgs.zellij;

    config.settings = {
      simplified_ui = true;
    };

    config.constructFiles.settings = {
      relPath = "zellij/config.kdl";
    };

    config.constructFiles.settings.content = wlib.toKdl (_: {  
      version = 1;  
      content = config.settings;  
    });

    config.env.ZELLIJ_CONFIG_FILE = config.constructFiles.settings.path;
  };
}
