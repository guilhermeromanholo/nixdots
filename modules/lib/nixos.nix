{ inputs, ... }:
{
  flake.lib.mkNixos =
    {
      name,
      system,
      version,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.self.modules.nixos.${name}

        { networking.hostName = name; }
        { system.stateVersion = version; }
        { nixpkgs.hostPlatform = system; }
      ];
    };
}
