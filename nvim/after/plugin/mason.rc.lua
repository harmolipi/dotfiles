local status, mason = pcall(require, 'mason')
if (not status) then return end
local status_mason_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
if (not status_mason_lspconfig) then return end
local status_lspconfig, lspconfig = pcall(require, 'lspconfig')
if (not status_lspconfig) then return end

mason.setup {}
mason_lspconfig.setup {
  ensure_installed = { 'tsserver', 'sumneko_lua', 'prettierd', 'hoon_ls' },
  automatic_installation = true,
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings

  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- formatting
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end


mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
  ['tsserver'] = function()
    lspconfig.tsserver.setup {
      on_attach = on_attach,
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
      cmd = { "typescript-language-server", "--stdio" },
      capabilities = capabilities
    }
  end,
  ['sumneko_lua'] = function()
    lspconfig.sumneko_lua.setup {
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the 'vim' global
            globals = { 'vim' }
          },

          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false
          }
        }
      }
    }
  end,
  ['emmet_ls'] = function()
    lspconfig.emmet_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
      init_options = {
        html = {
          options = {
            ["bem.enabled"] = true,
          },
        },
      },
    }
  end,
}
