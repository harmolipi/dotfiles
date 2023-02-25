local status, mason = pcall(require, 'mason')
if (not status) then return end
local status_mason_lspconfig, mason_lspconfig = pcall(require, 'mason-lspconfig')
if (not status_mason_lspconfig) then return end
local status_lspconfig, lspconfig = pcall(require, 'lspconfig')
if (not status_lspconfig) then return end

mason.setup {}
mason_lspconfig.setup {
  ensure_installed = { 'tsserver', 'sumneko_lua', 'hoon_ls', 'jsonls' },
  automatic_installation = true,
}

local lsp_highlight_document = function(client)
  -- Set autocommands conditional on server_capabilities
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  -- end
end

local formatting_callback = function(client, bufnr)
  -- formatting
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      -- callback = function() vim.lsp.buf.formatting_seq_sync() end
      callback = function() vim.lsp.buf.format() end
    })
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(
--   vim.lsp.protocol.make_client_capabilities()
-- )

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings

  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  lsp_highlight_document(client)

  -- Conditional for when I don't want it to run
  if client.name == 'tsserver' or client.name == 'html' or client.name == 'json' then
    vim.notify(client.name)
    -- client.resolved_capabilities.document_formatting = false
    client.server_capabilities.document_formatting = false
  end

  if client.name == 'html' then
    vim.notify(client.name)
    -- client.resolved_capabilities.document_formatting = false
    client.server_capabilities.document_formatting = false
  end

  local signature_setup = {
    bind = true,
    handler_opts = {
      border = "rounded"
    },
    auto_close_after = 3,
    hint_enable = false,
    hi_parameter = "IncSearch",
  }

  require 'lsp_signature'.on_attach(signature_setup, bufnr)

  formatting_callback(client, bufnr)
end

mason_lspconfig.setup_handlers {
  function(server_name)
    lspconfig[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
  ['html'] = function()
    lspconfig.html.setup {
      on_attach = on_attach,
      capabilities = capabilities
    }
  end,
  ['tsserver'] = function()
    lspconfig.tsserver.setup {
      on_attach = on_attach,
      filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
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
      filetypes = { 'html', 'php', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'css', 'sass',
        'scss', 'less' },
      init_options = {
        html = {
          options = {
            ["bem.enabled"] = true,
          },
        },
      },
    }
  end,
  ['jsonls'] = function()
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    }
  end,
  ['intelephense'] = function()
    lspconfig.intelephense.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          stubs = {
            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
            "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
            "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
            "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
            "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap",
            "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy",
            "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
            "wordpress", "phpunit",
          }
        }
      }
    }
  end,
  ['hoon_ls'] = function()
    lspconfig.hoon_ls.setup {}
  end,
}
