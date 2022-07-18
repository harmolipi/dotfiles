set backupskip=$TMPDIR/*,$TMP/*,$TEMP/*,/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

set noshowcmd
set noruler
set noshowmatch
set autochdir

runtime ./plug.vim " Plugins
runtime ./devaslife/init_takuya.vim " Takuya's (devaslife) config

tnoremap <Esc> <C-\><C-n> " Escape from terminal
nnoremap <C-`> :NvimTreeToggle<Return> " Open and close Nvim Tree
nnoremap <leader>ff <cmd>Telescope find_files<cr> " Fuzzy find files
nnoremap <silent> <leader>gg :LazyGit<cr> " Open lazygit

colorscheme NeoSolarized

" Lua settings
lua << EOF
-- Nvim-tree
require("nvim-tree").setup {
  view = {
    mappings = {
      list = {
        { key = "so", action = "system_open" }, -- Remove 's' key conflict with moving windows shortcut
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true, 
    },
  },
}

-- Lualine
require("lualine").setup {
  extensions = {"nvim-tree"},
}

-- Which-key
require("which-key").setup()

-- Nvim-treesitter
require("nvim-treesitter.configs").setup {
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
}

-- CMP
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, 
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Nvim-lsp-installer
require("nvim-lsp-installer").setup {
  automatic_installation = true,
}

-- Lsp-config
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- Tsserver
-- require('lspconfig').tsserver.setup {
--   capabilities = capabilities,
-- }

-- Quick_lint_js
require('lspconfig/quick_lint_js').setup {
  capabilities = capabilities,
}

-- Intelephense
require('lspconfig').intelephense.setup {
  capabilities = capabilities,
}

-- YAML
require('lspconfig').yamlls.setup {
  capabilities = capabilities,
}

require('lspconfig').emmet_ls.setup {
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
}

EOF
