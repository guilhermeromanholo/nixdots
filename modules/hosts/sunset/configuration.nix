{
  den.hosts.x86_64-linux.sunset = {
    users.guilherme = { };
  };

  den.aspects.sunset.nixos = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.neovim ];
  };
}
