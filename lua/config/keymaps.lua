-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Set keymaps to control the debugger

local vk = vim.keymap.set
vk("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selected down" })
vk("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selected up" })
vk("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- vk("n", "<C-A-o>", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Find symbols" })
vk("i", "jj", "<esc>")
-- vk("n", "<C-a>", "za", { desc = "Toggle fold" })
vk("n", "<A-p>", "<cmd>pu<cr>", { desc = "Paste below" })
vk("n", "<A-S-p>", "<cmd>pu!<cr>", { desc = "Paste above" })
vk("n", "<leader>?", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
vk("n", "<leader>s?", "<cmd>Cheatsheet<cr>", { desc = "Cheatsheet" })
vk("n", "<leader>um", "<cmd>messages<cr>", { desc = "Show messages" })
vk("n", "<C-d>", "<C-d>zz")
vk("n", "<C-u>", "<C-u>zz")
vk("x", "<leader>p", [["_dP]])
-- vk("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
