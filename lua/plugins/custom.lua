return {
  { "rcarriga/nvim-notify", enabled = false },
  { "folke/noice.nvim", enabled = false },
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({})
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      window = {
        mappings = {
          ["/"] = "noop",
          ["#"] = "fuzzy_finder",
        },
      },
    },
  },
  { "carlosrocha/chrome-remote.nvim", enabled = false },
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  -- override nvim-cmp and add cmp-emoji
  { "DasGandlaf/nvim-autohotkey" },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- print(vim.inspect(opts))
      table.insert(opts.sources, { name = "autohotkey" })
    end,
  },
  { "folke/which-key.nvim", opts = {
    defaults = {
      ["<leader>p"] = { name = "+paste" },
    },
  } },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup()
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    init = function()
      require("mini.ai").setup({})
      require("mini.notify").setup({})
      require("mini.splitjoin").setup({})
      require("mini.align").setup({})
      require("mini.bracketed").setup({})

      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          right = "<M-l>",
          left = "<M-h>",
          down = "<M-j>",
          up = "<M-k>",

          -- Move current line in Normal mode
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      })
    end,
  },
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
  { "tpope/vim-rhubarb" },
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
    -- enabled = false,
    opts = {
      options = {
        style_preset = require("bufferline").style_preset.minimal, -- or bufferline.style_preset.minimal,
        show_buffer_close_icons = false,
        show_close_icon = false,
        -- separator_style = "slant",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
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
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        winblend = 20,
      },
    },
  },

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
      local separator_style = "round"
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
          a = { fg = colors.base02, bg = colors.base1 },
          b = { fg = colors.base2, bg = colors.base04 },
          c = { fg = colors.base04, bg = colors.base04 },
        },
      }

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end

      local sections = {}

      -- local gitsigns = vim.b.gitsigns_status_dict
      local ilazy = require("lazyvim.config").icons
      local icons = {
        vim = "",
        git = "",
        diff = { added = ilazy.git.added, modified = ilazy.git.modified, removed = ilazy.git.removed },
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
          separator = { left = icons.block.left, right = icons[separator_style].right },
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
          -- cond = hide_in_width,
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
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
          -- cond = hide_in_width,
        },
      })

      local Util = require("lazyvim.util")
      ins_config("x", {
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = Util.ui.fg("Statement"),
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = Util.ui.fg("Constant"),
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = Util.ui.fg("Debug"),
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = Util.ui.fg("Special"),
        },
      })

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
          separator = { left = icons[separator_style].left },
          -- cond = hide_in_width,
        },
        {
          "location",
          -- cond = hide_in_width,
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
        {
          function()
            return " " .. os.date("%R")
          end,
        },
      })

      require("lualine").setup({
        options = {
          theme = custom_theme,
          component_separators = "",
          section_separators = { left = icons[separator_style].right, right = icons[separator_style].left },
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter", "NvimTree", "lazy", "neo-tree" } },
          -- refresh = {
          --   statusline = 1000,
          -- },
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
        -- winbar = {
        --   lualine_a = { "buffers" },
        --   lualine_b = {},
        --   lualine_c = {},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = { "tabs" },
        -- },
        -- inactive_winbar = {
        --   lualine_a = { "buffers" },
        --   lualine_b = {},
        --   lualine_c = {},
        --   lualine_x = {},
        --   lualine_y = {},
        --   lualine_z = { "tabs" },
        -- },
        extensions = {},
      })
    end,
  },
}
