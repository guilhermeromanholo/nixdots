{
  fetchFromGitHub,
  stdenvNoCC,
  kdePackages,
}:
stdenvNoCC.mkDerivation {
  pname = "sddm-silent";
  version = "1.4.2";

  src = fetchFromGitHub {
    owner = "uiriansan";
    repo = "SilentSDDM";
    tag = "v1.4.2";
    hash = "sha256-WeoJBj/PhqFCCJEIycTipqPbKm5BpQT2uzFTYcYZ30I=";
  };

  propagatedBuildInputs = with kdePackages; [
    qtmultimedia
    qtsvg
    qtvirtualkeyboard
  ];

  dontWrapQtApps = true;

  installPhase = let
    basePath = "$out/share/sddm/themes/silent";
  in ''
    mkdir -p "${basePath}"
    cp -r $src/* "${basePath}"
  '';
}
