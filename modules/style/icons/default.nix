{
  theme,
  pkgs,
  ...
}: {
  gtk = {
    iconTheme = {
      name = theme.icon.name;
      package = pkgs.${theme.icon.package};
    };
  };
}
