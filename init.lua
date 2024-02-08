-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.neovide_transparency = 0.92
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_vfx_mode = ""
vim.o.guifont = "FiraCode Nerd Font:h14"
vim.g.neovide_cursor_trail_size = 0.25
require("config.lazy")
