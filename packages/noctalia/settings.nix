{ pkgs, theme }:
{
  theme = {
    mode = "dark";
    source = "custom";
    custom_palette = "palette";
  };

  wallpaper.default = {
    path = theme.wallpaper;
  };

  bar.default = {
    capsule = true;

    margin_edge = 8;
    margin_ends = 10;

    border_width = 1.0;
    capsule_radius = 4;

    concave_edge_corners = false;

    center = [
      "tray"
      "clock"
    ];

    end = [
      "bar"
      "group:g2"
      "volume"
      "notifications"
      "session"
    ];

    start = [
      "launcher"
      "workspaces"
      "group:g1"
      "widget"
    ];

    capsule_group = [
      {
        id = "g1";
        accordion = false;
        accordion_direction = "end";
        enabled = true;
        fill = "surface_variant";
        members = [
          "cpu"
          "ram"
        ];
        opacity = 1.0;
        padding = 6.0;
      }

      {
        id = "g2";
        accordion = false;
        accordion_direction = "end";
        enabled = true;
        fill = "surface_variant";
        members = [
          "network"
          "bluetooth"
          "brightness"
          "battery"
        ];
        opacity = 1.0;
        padding = 6.0;
      }
    ];
  };

  location.address = "São José do Rio Preto, Brazil";

  plugins.enabled = [
    "rylos/tailnet"
    "aabidk20/yt-music"
  ];

  widget = {
    bar = {
      type = "rylos/tailnet:bar";
      show_count = false;
    };

    cpu = {
      show_value = false;
    };

    clock = {
      format = "  {:%H:%M}    {:%b %d}";
      vertical_format = "     {: %H %M}";
    };

    session = {
      color = "tertiary";
      custom_image_colorize = true;
    };

    widget = {
      type = "aabidk20/yt-music:widget";
    };

    network = {
      show_label = false;
    };

    ram = {
      show_value = false;
    };

    sysmon = {
      stat = "ram_used";
    };

    tray = {
      drawer = true;
    };

    weather = {
      show_condition = false;
    };

    launcher = {
      custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    };
  };
}
