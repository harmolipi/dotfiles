set backupskip=$TMPDIR/*,$TMP/*,$TEMP/*,/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

tnoremap <Esc> <C-\><C-n>

set noshowcmd
set noruler
set noshowmatch
set autochdir

" Takuya's (devaslife) config
runtime ./plug.vim
runtime ./devaslife/init_takuya.vim

nnoremap <C-`> :NvimTreeToggle<Return> " Open and close Nvim Tree
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <silent> <leader>gg :LazyGit<cr>

colorscheme NeoSolarized

lua << EOF
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

require("lualine").setup {
  extensions = {"nvim-tree"},
}

require("which-key").setup()

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

require("nvim-lsp-installer").setup {
  automatic_installation = true,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- require('lspconfig').tsserver.setup {}

require('lspconfig/quick_lint_js').setup {}
require('lspconfig').intelephense.setup {}
EOF
