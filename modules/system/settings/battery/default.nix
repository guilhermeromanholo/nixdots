{
  flake.modules.nixos.battery = {
    powerManagement.powertop.enable = true;

    services = {
      thermald.enable = true;
      power-profiles-daemon.enable = false;

      tlp = {
        enable = true;
        settings = {
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;

          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";

          PLATFORM_PROFILE_ON_AC = "performance";
          PLATFORM_PROFILE_ON_BAT = "balanced";

          STOP_CHARGE_THRESH_BAT0 = 95;
        };
      };
    };
  };
}
