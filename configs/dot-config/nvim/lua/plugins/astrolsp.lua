---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      autoformat = true,
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
      },
      timeout_ms = 1000,
    },
    servers = {
      "lua_ls",
      "nil_ls",
      "elixirls",
      -- elixirls = {
      --   cmd = { "elixir-ls" },
      -- },
      "ts_ls",
      "gopls",
    },
    ---@diagnostic disable: missing-fields
    config = {
      elixirls = {
        cmd = { "elixir-ls" },
        settings = {
          elixirLS = {
            dialyzerEnabled = false,
            fetchDeps = false,
            enableTestLenses = false,
          },
        },
      },
      -- intelephense = {
      --   settings = {
      --     intelephense = {
      --       stubs = {
      --         "apache",
      --         "bcmath",
      --         "bz2",
      --         "calendar",
      --         "com_dotnet",
      --         "Core",
      --         "ctype",
      --         "curl",
      --         "date",
      --         "dba",
      --         "dom",
      --         "enchant",
      --         "exif",
      --         "FFI",
      --         "fileinfo",
      --         "filter",
      --         "fpm",
      --         "ftp",
      --         "gd",
      --         "gettext",
      --         "gmp",
      --         "hash",
      --         "iconv",
      --         "imap",
      --         "intl",
      --         "json",
      --         "ldap",
      --         "libxml",
      --         "mbstring",
      --         "meta",
      --         "mysqli",
      --         "oci8",
      --         "odbc",
      --         "openssl",
      --         "pcntl",
      --         "pcre",
      --         "PDO",
      --         "pdo_ibm",
      --         "pdo_mysql",
      --         "pdo_pgsql",
      --         "pdo_sqlite",
      --         "pgsql",
      --         "Phar",
      --         "posix",
      --         "pspell",
      --         "readline",
      --         "Reflection",
      --         "session",
      --         "shmop",
      --         "SimpleXML",
      --         "snmp",
      --         "soap",
      --         "sockets",
      --         "sodium",
      --         "SPL",
      --         "sqlite3",
      --         "standard",
      --         "superglobals",
      --         "sysvmsg",
      --         "sysvsem",
      --         "sysvshm",
      --         "tidy",
      --         "tokenizer",
      --         "xml",
      --         "xmlreader",
      --         "xmlrpc",
      --         "xmlwriter",
      --         "xsl",
      --         "Zend OPcache",
      --         "zip",
      --         "zlib",
      --         "wordpress",
      --         "phpunit",
      --       },
      --     },
      --   },
      -- },
    },
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
  },
}
