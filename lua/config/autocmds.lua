-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  pattern = "*.ahk,*.ahk2,*.ah2",
  callback = function(ev)
    -- print(string.format("event fired: %s", vim.inspect(ev)))
    local lsp = vim.lsp.get_clients()[1]
    local content = vim.api.nvim_buf_get_lines(0, 0, 30, false)[1] or ""
    vim.opt.ft = "autohotkey"
    if
      vim.regex([[ahk2$\|ah2$]]):match_str(ev.match) ~= nil
      or vim.regex([[.*requires ahk v2.*\c]]):match_str(content) ~= nil
    then
      vim.b[0].ahk_version = 2
    else
      vim.b[0].ahk_version = 1
      -- local obj = vim.lsp.get_active_clients({ bufnr = 0 })[1]
      -- if obj ~= nil then
      --   local client_id = obj.dynamic_capabilities.client_id
      --   if obj.name == "ahk2" then
      --     vim.lsp.stop_client(client_id)
      --   end
      -- end
    end
  end,
})

-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
-- vim.api.nvim_create_autocmd("FileType", {
--   vim.lsp.start({
--     name = 'autohotkey_v1',
--     cmd = { "command" },
--     root_dir = vim.fn.getcwd(), -- Use PWD as project root dir.
--   })
-- })
-- Location information about the last message printed. The format is
-- `(did print, buffer number, line number)`.
--
-- local last_echo = { false, -1, -1 }
--
-- -- The timer used for displaying a diagnostic in the commandline.
-- local echo_timer = nil
--
-- -- The timer after which to display a diagnostic in the commandline.
-- local echo_timeout = 250
--
-- -- The highlight group to use for warning messages.
-- local warning_hlgroup = 'WarningMsg'
--
-- -- The highlight group to use for error messages.
-- local error_hlgroup = 'ErrorMsg'
--
-- -- If the first diagnostic line has fewer than this many characters, also add
-- -- the second line to it.
-- local short_line_limit = 20
--
-- -- Shows the current line's diagnostics in a floating window.
-- function show_line_diagnostics()
--   vim
--       .lsp
--       .diagnostic
--       .show_line_diagnostics({ severity_limit = 'Warning' }, vim.fn.bufnr(''))
-- end
--
-- -- Prints the first diagnostic for the current line.
-- function echo_diagnostic()
--   if echo_timer then
--     echo_timer:stop()
--   end
--
--   echo_timer = vim.defer_fn(
--     function()
--       local line = vim.fn.line('.') - 1
--       local bufnr = vim.api.nvim_win_get_buf(0)
--
--       if last_echo[1] and last_echo[2] == bufnr and last_echo[3] == line then
--         return
--       end
--
--       local diags = vim
--           .lsp
--           .diagnostic
--           .get_line_diagnostics(bufnf, line, { severity_limit = 'Warning' })
--
--       if #diags == 0 then
--         -- If we previously echo'd a message, clear it out by echoing an empty
--         -- message.
--         if last_echo[1] then
--           last_echo = { false, -1, -1 }
--
--           vim.api.nvim_command('echo ""')
--         end
--
--         return
--       end
--
--       last_echo = { true, bufnr, line }
--
--       local diag = diags[1]
--       local width = vim.api.nvim_get_option('columns') - 15
--       local lines = vim.split(diag.message, "\n")
--       local message = lines[1]
--       local trimmed = false
--
--       if #lines > 1 and #message <= short_line_limit then
--         message = message .. ' ' .. lines[2]
--       end
--
--       if width > 0 and #message >= width then
--         message = message:sub(1, width) .. '...'
--       end
--
--       local kind = 'warning'
--       local hlgroup = warning_hlgroup
--
--       if diag.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
--         kind = 'error'
--         hlgroup = error_hlgroup
--       end
--
--       local chunks = {
--         { kind .. ': ', hlgroup },
--         { message }
--       }
--
--       vim.api.nvim_echo(chunks, false, {})
--     end,
--     echo_timeout
--   )
-- end
--
-- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
--   -- group = augroup("resize_splits"),
--   callback = echo_diagnostic,
-- })
