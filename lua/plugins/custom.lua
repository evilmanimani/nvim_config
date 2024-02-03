return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  { "rcarriga/nvim-notify", opts = { stages = "static" } },
  { "tpope/vim-fugitive" },
  -- {
  --   "ahmedkhalf/project.nvim",
  --   config = function() end,
  --   opts = {
  --     show_hidden = true,
  --     silent_chdir = false,
  --     patterns = { ".git", "package.json", "index.html", "popup.js", "init.lua" },
  --   },
  -- },
  { "mbbill/undotree" },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        show_buffer_close_icons = false,
        separator_style = "slant",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true<cr>",
        desc = "Switch Buffer",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        path_display = { "truncate" },
        winblend = 20,
      },
    },
  },

  -- the opts function can also be used to change the default opts:
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = {
  --     options = {
  --       section_separators = { left = "", right = "" },
  --       component_separators = { left = "", right = "" },
  --     },
  --   },
  -- },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- highlight = { enable = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>", -- set to `false` to disable one of the mappings
          node_incremental = "<TAB>",
          scope_incremental = "<CR>",
          node_decremental = "<S-TAB>",
        },
      },
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "<c-space>",
      --     node_incremental = "<c-space>",
      --     scope_incremental = "<c-s>",
      --     node_decremental = "<M-space>",
      --   },
      -- },
      ensure_installed = {
        "vimdoc",
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local solarized_palette = require("solarized.palette")
      local colors = solarized_palette.get_colors()

      local custom_theme = {
        normal = {
          a = { fg = colors.base03, bg = colors.blue },
          b = { fg = colors.base02, bg = colors.base1 },
          c = { fg = colors.base2, bg = colors.base03 },
        },
        insert = {
          a = { fg = colors.base03, bg = colors.green },
        },
        visual = {
          a = { fg = colors.base03, bg = colors.magenta },
        },
        replace = {
          a = { fg = colors.base03, bg = colors.red },
        },
        command = {
          a = { fg = colors.base03, bg = colors.red },
        },
        inactive = {
          a = { fg = colors.base02, bg = colors.base04 },
          b = { fg = colors.base2, bg = colors.base04 },
          c = { fg = colors.base04, bg = colors.base04 },
        },
      }

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local sections = {}

      local icons = {
        vim = "",
        git = "",
        diff = { added = "󰐕", modified = "󰧞", removed = "󰍴" },
        default = { left = "", right = " " },
        round = { left = "", right = "" },
        block = { left = "█", right = "█" },
        arrow = { left = "", right = "" },
      }

      local function ins_config(location, component)
        sections["lualine_" .. location] = component
      end

      ins_config("a", {
        {
          "mode",
          icon = icons.vim,
          separator = { left = icons.block.left, right = icons.default.right },
          right_padding = 2,
        },
      })

      ins_config("b", {
        {
          "filename",
          fmt = function(filename)
            local icon = "󰈚"

            local devicons_present, devicons = pcall(require, "nvim-web-devicons")

            if devicons_present then
              local ft_icon = devicons.get_icon(filename)
              icon = (ft_icon ~= nil and ft_icon) or icon
            end

            return string.format("%s %s", icon, filename)
          end,
        },
      })

      ins_config("c", {
        {
          "branch",
          icon = { icons.git, color = { fg = colors.magenta } },
          cond = hide_in_width,
        },
        {
          "diff",
          symbols = icons.diff,
          colored = true,
          diff_color = {
            added = { fg = colors.green },
            modified = { fg = colors.orange },
            removed = { fg = colors.red },
          },
          cond = hide_in_width,
        },
      })

      ins_config("x", {})

      ins_config("y", {
        {
          "progress",
          fmt = function(progress)
            local spinners = { "󰚀", "󰪞", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰚀" }

            if string.match(progress, "%a+") then
              return progress
            end

            local p = tonumber(string.match(progress, "%d+"))

            if p ~= nil then
              local index = math.floor(p / (100 / #spinners)) + 1
              return "  " .. spinners[index]
            end
          end,
          separator = { left = icons.default.left },
          cond = hide_in_width,
        },
        {
          "location",
          cond = hide_in_width,
        },
      })

      ins_config("z", {
        {
          function()
            local msg = "No Active Lsp"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
              return msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                if client.name ~= "null-ls" then
                  return client.name
                end
              end
            end
            return msg
          end,
        },
      })

      require("lualine").setup({
        options = {
          theme = custom_theme,
          component_separators = "",
          section_separators = { left = icons.default.right, right = icons.default.left },
          disabled_filetypes = {
            "NvimTree",
            "starter",
          },
          refresh = {
            statusline = 1000,
          },
        },
        sections = sections,
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { "location" },
        },
        tabline = {},
        extensions = {},
      })
    end,
  },
}
