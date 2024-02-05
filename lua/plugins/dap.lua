if true then return {} end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mxsdev/nvim-dap-vscode-js",
  },
  config = function()
    local dap = require("dap")

    -- dap.adapters["pwa-chrome"] = {
    --   type = "server",
    --   host = "localhost",
    --   port = "${port}",
    --   executable = {
    --     -- command = "node",
    --     -- -- 💀 Make sure to update this path to point to your installation
    --     -- args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
    --     command = "js-debug-adapter",
    --     args = { "${port}" },
    --   },
    -- }

    require("dap-vscode-js").setup({
      node_path = "C:\\Users\\dmcleod\\AppData\\Local\\NodeJS\\node.exe",
      port = "${port}",
      debugger_path = vim.fn.stdpath("data") .. "\\mason\\packages\\js-debug-adapter\\js-debug",
      -- debugger_path = vim.fn.stdpath("data") .. "\\lazy\\vscode-js-debug",
      adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })

    local Config = require("lazyvim.config")
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end

    for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
      dap.configurations[language] = {
        -- attach to a node process that has been started with
        -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
        -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
        {
          type = "pwa-chrome",
          name = "Viv. Attach",
          request = "attach",
          -- url = "http://localhost:5173",
          -- sourceMaps = false,
          protocol = "inspector",
          port = 5000,
          webRoot = "${workspaceFolder}",
          -- skip files from vite's hmr
          urlFilter = "*afokpdobmmodpodgamfhiiajlffmlbpg*",
          skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          localRoot = vim.fn.getcwd(),
          remoteRoot = "/src"
        },
        {
          -- use nvim-dap-vscode-js's pwa-node debug adapter
          type = "pwa-node",
          -- attach to an already running node process with --inspect flag
          -- default port: 9222
          request = "attach",
          -- allows us to pick the process using a picker
          processId = require 'dap.utils'.pick_process,
          -- name of the debug action you have to select for this config
          name = "Attach debugger to existing `node --inspect` process",
          -- for compiled languages like TypeScript or Svelte.js
          sourceMaps = true,
          -- resolve source maps in nested locations while ignoring node_modules
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**" },
          -- path to src in vite based projects (and most other projects as well)
          cwd = "${workspaceFolder}/src",
          -- we don't want to debug code inside node_modules, so skip it!
          skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
        },
        {
          type = "pwa-chrome",
          name = "Launch Chrome to debug client",
          request = "launch",
          url = "http://localhost:5173",
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}/src",
          -- skip files from vite's hmr
          skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
        },
        -- only if language is javascript, offer this debug action
        language == "javascript" and {
          -- use nvim-dap-vscode-js's pwa-node debug adapter
          type = "pwa-node",
          -- launch a new process to attach the debugger to
          request = "launch",
          -- name of the debug action you have to select for this config
          name = "Launch file in new node process",
          -- launch current file
          program = "${file}",
          cwd = "${workspaceFolder}",
        } or nil,
      }
    end
  end
}
