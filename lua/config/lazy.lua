local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    {
      "MaximilianLloyd/ascii.nvim",
      event = "VimEnter",
      dependencies = {
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("telescope").load_extension("ascii")
      end,
    },
    -- {
    --   "mfussenegger/nvim-dap",
    --   dependencies = {
    --     {
    --       "rcarriga/nvim-dap-ui",
    --       -- stylua: ignore
    --       keys = {
    --         { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
    --         { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    --       },
    --       opts = {},
    --       config = function(_, opts)
    --         -- setup dap config by VsCode launch.json file
    --         -- require("dap.ext.vscode").load_launchjs()
    --         local dap = require("dap")
    --         local dapui = require("dapui")
    --         dapui.setup(opts)
    --         dap.listeners.after.event_initialized["dapui_config"] = function()
    --           dapui.open({})
    --         end
    --         dap.listeners.before.event_terminated["dapui_config"] = function()
    --           dapui.close({})
    --         end
    --         dap.listeners.before.event_exited["dapui_config"] = function()
    --           dapui.close({})
    --         end
    --       end,
    --     },
    --     {
    --       "theHamsta/nvim-dap-virtual-text",
    --       opts = {},
    --     },
    --     {
    --       "folke/which-key.nvim",
    --       optional = true,
    --       opts = {
    --         defaults = {
    --           ["<leader>d"] = { name = "+debug" },
    --         },
    --       },
    --     },
    --     "mxsdev/nvim-dap-vscode-js",
    --     -- build debugger from source
    --     {
    --       "microsoft/vscode-js-debug",
    --       version = 'v1.76.1',
    --       timeout = '12000',
    --       build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    --     }
    --   },
    --   keys = {
    --     { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    --     { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    --     { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
    --     { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
    --     { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    --     { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
    --     { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
    --     { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
    --     { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
    --     { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
    --     { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
    --     { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
    --     { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
    --     { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
    --     { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
    --     { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
    --     { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    --   },
    --   config = function()
    --     require("dap-vscode-js").setup({
    --       node_path = "C:\\Users\\dmcleod\\AppData\\Local\\NodeJS\\node.exe",
    --       port = "${port}",
    --       -- debugger_path = vim.fn.stdpath("data") .. "\\mason\\packages\\js-debug-adapter\\js-debug",
    --       debugger_path = vim.fn.stdpath("data") .. "\\lazy\\vscode-js-debug",
    --       adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    --     })
    --     local dap = require("dap")
    --
    --     local Config = require("lazyvim.config")
    --     vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    --     for name, sign in pairs(Config.icons.dap) do
    --       sign = type(sign) == "table" and sign or { sign }
    --       vim.fn.sign_define(
    --         "Dap" .. name,
    --         { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --       )
    --     end
    --
    --     for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
    --       dap.configurations[language] = {
    --         -- attach to a node process that has been started with
    --         -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
    --         -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
    --         {
    --           type = "pwa-chrome",
    --           name = "Viv. Attach",
    --           request = "attach",
    --           -- url = "http://localhost:5173",
    --           -- sourceMaps = false,
    --           protocol = "inspector",
    --           port = 5000,
    --           webRoot = "${workspaceFolder}",
    --           -- skip files from vite's hmr
    --           urlFilter = "*afokpdobmmodpodgamfhiiajlffmlbpg*",
    --           skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
    --           localRoot = vim.fn.getcwd(),
    --           remoteRoot = "/src"
    --         },
    --         {
    --           -- use nvim-dap-vscode-js's pwa-node debug adapter
    --           type = "pwa-node",
    --           -- attach to an already running node process with --inspect flag
    --           -- default port: 9222
    --           request = "attach",
    --           -- allows us to pick the process using a picker
    --           processId = require 'dap.utils'.pick_process,
    --           -- name of the debug action you have to select for this config
    --           name = "Attach debugger to existing `node --inspect` process",
    --           -- for compiled languages like TypeScript or Svelte.js
    --           sourceMaps = true,
    --           -- resolve source maps in nested locations while ignoring node_modules
    --           resolveSourceMapLocations = {
    --             "${workspaceFolder}/**",
    --             "!**/node_modules/**" },
    --           -- path to src in vite based projects (and most other projects as well)
    --           cwd = "${workspaceFolder}/src",
    --           -- we don't want to debug code inside node_modules, so skip it!
    --           skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
    --         },
    --         {
    --           type = "pwa-chrome",
    --           name = "Launch Chrome to debug client",
    --           request = "launch",
    --           url = "http://localhost:5173",
    --           sourceMaps = true,
    --           protocol = "inspector",
    --           port = 9222,
    --           webRoot = "${workspaceFolder}/src",
    --           -- skip files from vite's hmr
    --           skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
    --         },
    --         -- only if language is javascript, offer this debug action
    --         language == "javascript" and {
    --           -- use nvim-dap-vscode-js's pwa-node debug adapter
    --           type = "pwa-node",
    --           -- launch a new process to attach the debugger to
    --           request = "launch",
    --           -- name of the debug action you have to select for this config
    --           name = "Launch file in new node process",
    --           -- launch current file
    --           program = "${file}",
    --           cwd = "${workspaceFolder}",
    --         } or nil,
    --       }
    --     end
    --
    --     -- require("dapui").setup()
    --     -- local dap, dapui = require("dap"), require("dapui")
    --     -- dap.listeners.after.event_initialized["dapui_config"] = function()
    --     --   dapui.open({ reset = true })
    --     -- end
    --     -- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    --     -- dap.listeners.before.event_exited["dapui_config"] = dapui.close
    --   end
    -- },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
