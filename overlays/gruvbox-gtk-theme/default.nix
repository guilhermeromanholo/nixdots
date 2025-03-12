{prev}:
prev.gruvbox-gtk-theme.overrideAttrs (oldAttrs: {
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes
    cd themes

    ./install.sh -n Gruvbox -t grey --tweaks medium float -d $out/share/themes

    runHook postInstall
  '';
})
