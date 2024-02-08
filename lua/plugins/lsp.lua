if true then
  return {}
end
return {
  "neovim/nvim-lspconfig",
  init = function()
    local nvim_lsp = require("lspconfig")
    -- local lsp_signature = require("noice.lsp.signature")
    -- lsp_signature.setup({})
    local ahk2_configs = {
      autostart = true,
      single_file_support = true,
      root_dir = function()
        return false
      end, --nvim_lsp.util.root_pattern("*.ahk"),
      cmd = {
        "node",
        vim.fn.expand("$HOME/AppData/Local/nvim-data/vscode-autohotkey2-lsp/server/dist/server.js"),
        "--stdio",
      },
      filetypes = { "autohotkey" },
      init_options = {
        locale = "en-us",
        InterpreterPath = "C:/Program Files/AutoHotkey/v2/AutoHotkey.exe",
        AutoLibInclude = "Disabled", -- or "Local" or "User and Standard" or "All"
        CommentTags = "^;;\\s*(?<tag>.+)",
        CompleteFunctionParens = false,
        Diagnostics = {
          ClassStaticMemberCheck = true,
          ParamsCheck = true,
        },
        -- Same as initializationOptions for Sublime Text4, convert json literal to lua dictionary literal
        single_file_support = true,
        flags = { debounce_text_changes = 500 },
        capabilities = capabilities,
        -- on_attach = lsp_signature.on_attach({
        --   bind = true,
        --   use_lspsaga = false,
        --   floating_window = true,
        --   fix_pos = true,
        --   hint_enable = true,
        --   hi_parameter = "Search",
        --   handler_opts = { "double" },
        -- }),
      },
    }
    local configs = require("lspconfig.configs")
    configs["ahk2"] = { default_config = ahk2_configs }
    nvim_lsp.ahk2.setup({
      on_attach = function(client)
        local version = vim.b[0].ahk_version
        -- if version ~= 2 then
        --   client.config.autostart = false
        --   client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        -- end
        return true
      end,
    })
  end,
}
