if true then return {} end

return {
  "nvim-tree/nvim-tree.lua",
  init = function()
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
      -- required for project.nvim
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    })
    vim.keymap.set("n", "<leader>e", function()
      require("nvim-tree.api").tree.toggle()
    end, { desc = "Toggle tree" })
  end,
}
