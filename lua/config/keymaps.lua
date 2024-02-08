-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Set keymaps to control the debugger

local vk = vim.keymap.set
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  vim.cmd("redraw!")
end
vk("n", "<C-=>", function()
  change_scale_factor(1.10)
end)
vk("n", "<C-->", function()
  change_scale_factor(1 / 1.10)
end)
if vim.g.neovide then
  vk("n", "<C-s>", ":w<CR>") -- Save
  vk("v", "<C-c>", '"+y') -- Copy
  vk("n", "<C-v>", '"+P') -- Paste normal mode
  vk("v", "<C-v>", '"+P') -- Paste visual mode
  vk("c", "<C-v>", "<C-R>+") -- Paste command mode
  vk("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode
end

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })

vk("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selected down" })
vk("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selected up" })
vk("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- vk("n", "<C-A-o>", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Find symbols" })
vk("i", "jj", "<esc>", { desc = "<ESC>" })
vk(
  "n",
  "<leader>e",
  "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), false)<cr>",
  { desc = "Open mini.files" }
)
-- vk("n", "<C-a>", "za", { desc = "Toggle fold" })
vk("n", "<leader>pj", "<cmd>pu<cr>", { desc = "Paste below" })
vk("n", "<leader>pk", "<cmd>pu!<cr>", { desc = "Paste above" })
vk("n", "<leader>pp", "$p", { desc = "Paste at end of line" })
vk("n", "<leader>?", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
vk("n", "<leader>s?", "<cmd>Cheatsheet<cr>", { desc = "Cheatsheet" })
vk("n", "<leader>um", "<cmd>messages<cr>", { desc = "Show messages" })
-- vk("n", "<C-l>", "<cmd>LspStop<cr>")
vk("v", "<F2>", "<cmd>'<,'>w !node<cr>", { desc = "Execute selection in Node" })
vk("n", "<C-d>", "<C-d>zz")
vk("n", "<C-u>", "<C-u>zz")
vk("n", "<C-u>", "<C-u>zz")
vk("x", "<leader>p", [["_dP]])
-- vk("n", "<F5>",
--   function()
--     -- (Re-)reads launch.json if present
--     local exists = vim.fn.filereadable(".vscode/launch.json")
--     print("launch.json found: " .. tostring(exists))
--     if exists then
--       require("dap.ext.vscode").load_launchjs(nil, {
--         ["pwa-chrome"] = { "javascript" },
--         ["chrome"] = { "javascript" },
--       })
--     end
--     require("dap").continue()
--   end,
--   { desc = "DAP Continue" }
-- )
-- vk("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
