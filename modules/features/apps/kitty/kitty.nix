{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.kitty = moduleWithSystem (
    { self', ... }: {
      programs.kitty = {
        enable = true;
        package = self'.packages.kitty;
      };
    }
  );

  perSystem = { pkgs, ... }: {
    packages.kitty = inputs.wrappers.wrappers.kitty.wrap {
      inherit pkgs;

      runtimePkgs = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      font = {
        name = "JetBrainsMono Nerd Font";
        size = 12;
      };

      settings = import ./_settings.nix { inherit (inputs.self.theme) colors; };
    };
  };
}
