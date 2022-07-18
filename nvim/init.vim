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

-- Nvim-lsp-installer
require("nvim-lsp-installer").setup {
  automatic_installation = true,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Lsp-config
require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- Tsserver
-- require('lspconfig').tsserver.setup {}

-- Quick_lint_js
require('lspconfig/quick_lint_js').setup {}

-- Intelephense
require('lspconfig').intelephense.setup {}
EOF
