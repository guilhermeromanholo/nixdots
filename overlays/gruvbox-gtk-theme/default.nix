{prev}:
prev.gruvbox-gtk-theme.overrideAttrs (oldAttrs: {
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes
    cd themes

    ./install.sh -n Gruvbox -t default --tweaks outline -d $out/share/themes

    cd $out/share/themes

    runHook postInstall
  '';
})
