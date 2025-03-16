{pkgs, ...}: {
  name = "poetry-shell";

  commands = [
    {
      name = "env";
      command = "echo $(poetry env activate)";
      help = "use 'eval $(env)'";
    }
  ];

  env = [
    {
      name = "LD_LIBRARY_PATH";
      value = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:$LD_LIBRARY_PATH";
    }
  ];

  packages = with pkgs; [
    poetry
    python312
  ];
}
