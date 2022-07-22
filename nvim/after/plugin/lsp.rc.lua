local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Lsp-config
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- Lspsaga
local saga = require 'lspsaga'
saga.init_lsp_saga()

-- ESLint
require('lspconfig').eslint.setup{}

-- Quick_lint_js
require('lspconfig/quick_lint_js').setup {
  capabilities = capabilities,
}

-- Intelephense
require('lspconfig').intelephense.setup {
  capabilities = capabilities,
}

-- YAMLls
require('lspconfig').yamlls.setup {
  capabilities = capabilities,
}

-- Emmet_ls
require('lspconfig').emmet_ls.setup {
  capabilities = capabilities,
  filetypes = { 'html', 'php', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
}

-- HTML
require('lspconfig').html.setup {
  capabilities = capabilities,
}

-- CSS
require('lspconfig').cssls.setup{
  capabilities = capabilities,
}

-- CSS modules
require('lspconfig').cssmodules_ls.setup{
    capabilities = capabilities,
}
