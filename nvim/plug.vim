if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'overcache/NeoSolarized'	" NeoSolarized theme

if has("nvim")
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'folke/which-key.nvim'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'quick-lint/quick-lint-js', {'rtp': 'plugin/vim/quick-lint-js.vim', 'tag': '2.7.0'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  Plug 'dag/vim-fish'
"  Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
"  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
endif

call plug#end()
