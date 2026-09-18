{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.noctalia = inputs.wrappers.lib.wrapPackage ({wlib, config, ...}: {
      inherit pkgs;
      imports = [wlib.modules.default];

      package = pkgs.noctalia;

      constructFiles."config.toml" = {
	relPath = "noctalia/config.toml";
	builder = ''cp ${./config.toml} "$2"'';
      };

      env.NOCTALIA_CONFIG_HOME = config.constructFiles."config.toml".path;
    });
  };
}
