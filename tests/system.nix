{
  inputs,
  lib,
  self,
}:
let
  makeSystem =
    modules:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        self.nixosModules.base
        {
          nixpkgs.hostPlatform = "x86_64-linux";
          system.stateVersion = "26.05";
        }
      ]
      ++ modules;
    };
  ordinary = makeSystem [
    { persist.root.directories = [ "/var/lib/example" ]; }
  ];
  persistent = makeSystem [
    self.nixosModules.impermanence
    {
      fileSystems."/persist" = {
        device = "/dev/disk/by-label/PERSIST";
        fsType = "ext4";
        neededForBoot = true;
      };
      persist.root.directories = [ "/var/lib/example" ];
      persist.user.directories = [ ".ssh" ];
      settings.user.name = "test";
    }
  ];
  customized = self.nixosConfigurations.tesla.extendModules {
    modules = [
      {
        settings.theme.name = "personal";
        settings.theme.colors.base00 = "#112233";
        settings.theme.fonts.size = 23;
      }
    ];
  };
  swaySystem = makeSystem [
    self.nixosModules.workstation
    self.nixosModules.sway-waybar
  ];
  swayConfig = (swaySystem.pkgs.my.sway.apply { }).constructFiles.swayConfig.content;
in
lib.runTests {
  testPersistenceContractWithoutImpermanence = {
    expr = {
      directories = ordinary.config.persist.root.directories;
      hasEngine = ordinary.config.environment ? persistence;
    };
    expected = {
      directories = [ "/var/lib/example" ];
      hasEngine = false;
    };
  };
  testImpermanenceConsumesSystemPaths = {
    expr = map (
      directory: directory.directory
    ) persistent.config.environment.persistence."/persist".directories;
    expected = [
      "/var/lib/nixos"
      "/var/lib/example"
    ];
  };
  testImpermanenceConsumesUserPaths = {
    expr = map (
      directory: directory.directory
    ) persistent.config.environment.persistence."/persist".users.test.directories;
    expected = [ ".ssh" ];
  };
  testSystemAndWrappersShareEffectiveTheme = {
    expr = {
      system = customized.config.settings.theme.colors.base00;
      wrapper = (customized.pkgs.my.kitty.apply { }).settings.background;
      size = (customized.pkgs.my.kitty.apply { }).settings.font_size;
    };
    expected = {
      system = "#112233";
      wrapper = "#112233";
      size = 23;
    };
  };
  testSwaySessionComposition = {
    expr =
      swaySystem.config.session.compositor == "sway"
      && lib.hasInfix "mode \"resize\" {" swayConfig
      && lib.hasInfix "waybar" swayConfig
      && lib.hasInfix "kitty" swayConfig;
    expected = true;
  };
  testEveryHostHasSharedContracts = {
    expr = lib.all (
      host:
      host.config.persist.root ? directories
      && host.config.session.bindings ? default
      && host.config.settings ? theme
    ) (builtins.attrValues self.nixosConfigurations);
    expected = true;
  };
}
