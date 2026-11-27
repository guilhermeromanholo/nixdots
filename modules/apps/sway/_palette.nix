{ theme }:
''
  font pango:${theme.fonts.sans.name} ${toString theme.fonts.size}
  output * bg ${theme.wallpaper.default} fill
  client.focused ${theme.colors.base0D} ${theme.colors.base00} ${theme.colors.base05} ${theme.colors.base0D} ${theme.colors.base0D}
  client.unfocused ${theme.colors.base01} ${theme.colors.base00} ${theme.colors.base04} ${theme.colors.base01} ${theme.colors.base01}
  client.focused_inactive ${theme.colors.base03} ${theme.colors.base00} ${theme.colors.base05} ${theme.colors.base03} ${theme.colors.base03}
  client.urgent ${theme.colors.base08} ${theme.colors.base00} ${theme.colors.base05} ${theme.colors.base08} ${theme.colors.base08}
''
