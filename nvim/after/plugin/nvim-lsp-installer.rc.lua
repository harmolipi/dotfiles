-- Nvim-lsp-installer
local status, lsp_installer = pcall(require, "nvim-lsp-installer")
if (not status) then
    return
end

package.path = "/Users/nikobirbilis/.config/nvim/after/plugin/?.lua;" .. package.path
local handlers = require("lsp-handlers")
handlers.setup()

local servers = {
    "cssls",
    "html",
    "tsserver",
    "jsonls",
    "yamlls",
    "eslint",
    "intelephense",
    "emmet_ls",
    "cssmodules_ls",
    "quick_lint_js",
    "sumneko_lua",
    "hoon_ls"
}

lsp_installer.setup {
    automatic_installation = true
}

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities
    }

    if server == "sumneko_lua" then
        local sumneko_opts = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim"}
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.stdpath "config" .. "/lua"] = true
                        }
                    }
                }
            }
        }
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    lspconfig[server].setup(opts)
end

-- Lspsaga
local saga = require "lspsaga"
saga.init_lsp_saga()
