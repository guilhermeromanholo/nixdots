{ inputs, ... }:
{
  flake.nixosModules.kitty = inputs.self.lib.mkModule (
    { self', ... }:
    {
      programs.kitty.enable = true;
      programs.kitty.package = self'.packages.kitty;
    }
  );

  perSystem = { pkgs, ... }: {
    packages.kitty = inputs.wrappers.wrappers.kitty.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      font = {
        size = 12;
        name = "JetBrainsMono Nerd Font";
      };

      settings = import ./_settings.nix { inherit (inputs.self.theme) colors; };
    };
  };
}
