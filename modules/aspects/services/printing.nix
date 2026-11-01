{
  den.aspects.printing = {
    nixos = { pkgs, ... }: {
      services.printing = {
        enable = true;
        drivers = [ pkgs.gutenprint ];
      };

      hardware.sane.enable = true;
    };

    persist.root.directories = [
      "/etc/cups"
    ];
  };
}
