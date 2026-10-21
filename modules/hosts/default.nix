{ self, inputs, ... }: {
  imports = [
    ./sunset.nix
    ./taz.nix
    ./vortex.nix
    ./tesla.nix
  ];
  flake.nixosConfigurations = builtins.listToAttrs (
    map
      (name: {
        inherit name;
        value = inputs.nixpkgs.lib.nixosSystem {
          modules = [ self.modules.nixos.${name} ];
        };
        # Tesla stays exportable as a module until its real hardware is supplied.
        # Do not publish a deliberately unbootable nixosConfiguration.
      })
      [
        "sunset"
        "taz"
        "vortex"
      ]
  );
}
