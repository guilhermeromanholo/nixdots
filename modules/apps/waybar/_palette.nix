{ theme }:
''
  @define-color background ${theme.colors.base00};
  @define-color foreground ${theme.colors.base05};
  @define-color accent ${theme.colors.base0D};
  @define-color muted ${theme.colors.base03};
  * {
    font-family: "${theme.fonts.sans.name}";
    font-size: ${toString theme.fonts.size}px;
  }
''
