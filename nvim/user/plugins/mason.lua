-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      -- ensure_installed = { "lua_ls" },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      -- ensure_installed = { "prettier", "stylua" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,
        firefox = function(config)
          local dap = require "dap"

          dap.configurations.javascript = {
            {
              name = 'Debug with Firefox',
              type = 'firefox',
              request = 'launch',
              reAttach = true,
              url = 'http://localhost:8080',
              webRoot = '${workspaceFolder}',
            }
          }
          require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
      }
    },
  },
}
