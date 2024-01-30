return {
  {
    "lrangell/theme-cycler.nvim",
    init = function()
      local tc = require("themeCycler")
      vim.keymap.set("n", "<space>uy", tc.open_lazy, { desc = "ThemeCycler" })
    end,
  },
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim", lazy = false },
  { "folke/tokyonight.nvim", lazy = false },
  {
    "maxmx03/solarized.nvim",
    transparent = true, -- enable transparent background
    -- palette = 'solarized',
    name = "solarized",
    enables = {
      editor = true,
      syntax = true,

      -- PLUGINS
      bufferline = true,
      cmp = true, -- disabled
      diagnostic = true,
      indentblankline = true,
      lsp = true,
      lspsaga = false, -- disabled
      navic = false,
      semantic = true,
      telescope = true,
      tree = true, -- disabled
      treesitter = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
      -- colorscheme = "tokyonight-night",
    },
  },
}
