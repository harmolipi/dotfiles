if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'overcache/NeoSolarized'   " NeoSolarized theme

if has("nvim")
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kyazdani42/nvim-tree.lua'
  Plug 'folke/which-key.nvim'
  " Plug 'quick-lint/quick-lint-js', {'rtp': 'plugin/vim/quick-lint-js.vim', 'tag': '2.7.0'}
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-lua/popup.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  " Plug 'dag/vim-fish'
  " Plug 'kdheepak/lazygit.nvim'
  " Plug 'rmagatti/auto-session'
  " Plug 'mattn/emmet-vim'
  " Plug 'mhinz/vim-startify'
  Plug 'windwp/nvim-autopairs'
  Plug 'norcalli/nvim-colorizer.lua'
  " Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'KabbAmine/vCoolor.vim'
  " Plug 'maxmellon/vim-jsx-pretty'
  " Plug 'github/copilot.vim'
  " Plug 'leafgarland/typescript-vim'
  " Plug 'jose-elias-alvarez/null-ls.nvim'
  " Plug 'lewis6991/gitsigns.nvim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'urbit/hoon.vim'
  Plug 'lukas-reineke/indent-blankline.nvim'

  "   COC plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "  CMP plugins
  " Plug 'hrsh7th/nvim-cmp'
  " Plug 'hrsh7th/cmp-nvim-lsp'
  " Plug 'hrsh7th/cmp-buffer'
  " Plug 'hrsh7th/cmp-path'
  " Plug 'saadparwaiz1/cmp_luasnip'
  " Plug 'hrsh7th/cmp-nvim-lsp'
  " Plug 'hrsh7th/cmp-nvim-lua'

  "  Snippets
  " Plug 'L3MON4D3/LuaSnip'
  " Plug 'SirVer/ultisnips'
  Plug 'rafamadriz/friendly-snippets'

  "  LSP
  " Plug 'neovim/nvim-lspconfig'
  " Plug 'williamboman/nvim-lsp-installer'
  " Plug 'glepnir/lspsaga.nvim'
  " Plug 'onsails/lspkind-nvim'

  "  Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
endif

call plug#end()
