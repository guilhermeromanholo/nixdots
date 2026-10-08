{ inputs, ... }:
{
  flake.lib.mkNixos =
    {
      name,
      system,
    }:
    {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}

          { networking.hostName = name; }
          { nixpkgs.hostPlatform = system; }
        ];
      };
    };
}
