{inputs, ...}: {
  flake.modules.homeManager.noctalia = {
    programs.noctalia-shell.settings = {
      general = {
        telemetryEnabled = false;
        showChangelogOnStartup = false;
      };

      location.autoLocate = true;
    };
  };
}
