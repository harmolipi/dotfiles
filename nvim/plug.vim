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
  Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  " Plug 'dag/vim-fish'
  " Plug 'kdheepak/lazygit.nvim'
  " Plug 'mattn/emmet-vim'
  " Plug 'mhinz/vim-startify'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  " Plug 'maxmellon/vim-jsx-pretty'
  " Plug 'github/copilot.vim'
  " Plug 'leafgarland/typescript-vim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'urbit/hoon.vim'
  Plug 'lukas-reineke/indent-blankline.nvim'

  "   COC plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  "  Snippets
  Plug 'honza/vim-snippets'
  Plug 'mlaursen/vim-react-snippets'

  "  Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'p00f/nvim-ts-rainbow'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
endif

call plug#end()
