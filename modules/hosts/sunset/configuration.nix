{ den, ... }:
{
  den.hosts.x86_64-linux.sunset = {
    users.guilherme = { };
  };

  den.aspects.sunset = { pkgs, ... }: {
    includes = with den.aspects; [
      # Host roles
      roles.default
    ];

    nixos.environment.systemPackages = [ pkgs.neovim ];
  };
}
