{ inputs, ... }:
{
  flake.lib.mkNixos =
    {
      name,
      version,
      system ? "x86_64-linux",
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
