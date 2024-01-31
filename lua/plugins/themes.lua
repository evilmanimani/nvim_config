-- local groups = { "Normal", "NormalFloat", "LineNr", "NvimTreeNormal", "CursorLineNr" }
-- for i, g in ipairs(groups) do
--   vim.api.nvim_set_hl(0, g, { bg = "none" })
-- end

return {
  -- {
  --   "lrangell/theme-cycler.nvim",
  --   init = function()
  --     local tc = require("themeCycler")
  --     vim.keymap.set("n", "<space>uy", tc.open_lazy, { desc = "ThemeCycler" })
  --   end,
  -- },
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim",         lazy = false },
  { "folke/tokyonight.nvim",   lazy = false },
  -- { "maxmx03/solarized.nvim",  opts = { theme = "neo" } },
  { "maxmx03/solarized.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "solarized",
      colorscheme = "tokyonight",
      -- colorscheme = "gruvbox",
    },
  },
}
