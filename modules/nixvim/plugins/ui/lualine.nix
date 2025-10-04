{
  plugins.lualine = {
    enable = true;

    settings = {
      options = {
        section_separators = "";
        component_separators = "";
      };

      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            icon = "";
          }
        ];

        lualine_b = [
          {
            __unkeyed = "filetype";
            icon_only = true;
            padding = {
              right = 0;
              left = 1;
            };
          }
          {
            __unkeyed = "filename";
            padding = {
              right = 1;
              left = 0;
            };
          }
        ];

        lualine_c = [
          {
            __unkeyed = "branch";
            icon = "";
          }
          {
            __unkeyed = "diff";
            colored = true;
            symbols = {
              added = "󰐖 ";
              modified = "󰍵 ";
              removed = "󰅗 ";
            };
          }
        ];

        lualine_x = ["diagnostics"];
        lualine_y = ["lsp_status"];
        lualine_z = ["progress"];
      };
    };
  };
}
