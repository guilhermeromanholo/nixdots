{
  flake.modules.homeManager.firefox = {
    programs.firefox = {
      enable = true;

      profiles = {
        personal = {
          id = 0;
          isDefault = true;

          settings = {
            "browser.startup.page" = 1;
            "browser.startup.homepage" = "https://web.whatsapp.com";
          };
        };

        work = {
          id = 1;
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
