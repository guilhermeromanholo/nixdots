{
  flake.aspects.browser.nixos = {
    programs.firefox = {
      enable = true;

      preferences = {
        "sidebar.verticalTabs" = true;
        "browser.cache.disk.enable" = false;
      };

      policies = {
        ExtensionSettings =
          let
            moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
          in
          {
            "*".installation_mode = "blocked";

            "uBlock0@raymondhill.net" = {
              install_url = moz "ublock-origin";
              installation_mode = "force_installed";
            };
            
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = moz "bitwarden-password-manager";
              installation_mode = "force_installed";
            };
          };

        profiles.work.search = {
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
        };

        profiles.personal.search = {
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
        };
      };
    };
  };
}
