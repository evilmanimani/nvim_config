return {
  -- butt
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "catppuccin/nvim", lazy = false },
  -- { "folke/tokyonight.nvim", lazy = false },
  {
    "maxmx03/solarized.nvim",
    init = function()
      vim.o.background = "dark"
    end,
    opts = {
      theme = "neo",
      palette = "solarized",
      -- palette = "selenized",
      transparent = false,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },
}
