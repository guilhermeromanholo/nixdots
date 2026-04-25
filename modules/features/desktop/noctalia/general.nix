{inputs, ...}: {
  flake.modules.homeManager.noctalia = {
    programs.noctalia-shell.settings = {
      general = {
        telemetryEnabled = false;
        showChangelogOnStartup = false;
      };

      location.autoLocate = true;
    };

    home.file.".cache/noctalia/shell-state.json".text = ''
      {
        "changelogState": {
          "lastSeenVersion": "4.0.2"
        }
      }
    '';
  };
}
