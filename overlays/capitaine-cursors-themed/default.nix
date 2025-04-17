{prev}:
prev.capitaine-cursors-themed.overrideAttrs (oldAttrs: {
  installPhase =
    oldAttrs.installPhase
    + ''
      cd $out/share/icons

      mv "Capitaine Cursors (Nord)" "Capitaine-Cursors-Nord"
      mv "Capitaine Cursors (Gruvbox)" "Capitaine-Cursors-Gruvbox"
    '';
})
