{pkgs, ...}: {
  name = "java-shell";

  packages = with pkgs; [
    # Java
    jdk
    maven
    # Jdtls
    python3
  ];
}
