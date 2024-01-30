return {
  "nvim-tree/nvim-tree.lua",
  init = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true

    -- require("nvim-tree").setup()
    -- OR setup with some options
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    })
    vim.keymap.set("n", "<leader>e", function()
      require("nvim-tree.api").tree.toggle()
    end, { desc = "Toggle tree" })
  end,
}
