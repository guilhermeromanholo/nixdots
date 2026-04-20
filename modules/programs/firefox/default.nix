{
  flake.modules.homeManager.firefox = {pkgs, ...}: let
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
      owasp-penetration-testing-kit
    ];
  in {
    programs.firefox = {
      enable = true;

      profiles = {
        personal = {
          id = 0;
          isDefault = true;
          extensions.packages = extensions;

          settings = {
            "browser.startup.page" = 1;
            "browser.startup.homepage" = "https://web.whatsapp.com";
          };
        };

        work = {
          id = 1;
          extensions.packages = extensions;

          settings = {
            "browser.startup.page" = 1;
            "browser.startup.homepage" = "https://mail.google.com|https://trello.com";
          };
        };
      };
    };
  };

  flake.modules.homeManager.impermanence = {
    home.persistence."/persist" = {
      directories = [
        ".mozilla"
      ];
    };
  };
}
