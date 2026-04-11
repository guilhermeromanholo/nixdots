{
  flake.modules.nixos.docker = {pkgs, ...}: {
    programs.dconf.enable = true;
    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
