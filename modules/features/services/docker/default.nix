{
  flake.modules.nixos.docker = {
    pkgs,
    lib,
    ...
  }: {
    programs.dconf.enable = true;

    virtualisation.docker.enable = true;

    systemd = {
      sockets.docker.wantedBy = ["sockets.target"];
      services.docker.wantedBy = lib.mkForce [];
    };

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
