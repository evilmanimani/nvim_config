-- bootstrap lazy.nvim, LazyVim and your plugins
vim.g.neovide_transparency = 0.95
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scale_factor = 0.86247
vim.g.neovide_fullscreen = true
vim.g.neovide_cursor_vfx_mode = ""
vim.o.guifont = "FiraCode Nerd Font:h14"
vim.o.shell = "powershell"
vim.g.neovide_cursor_trail_size = 0.25
vim.o.showtabline = 0
require("config.lazy")
