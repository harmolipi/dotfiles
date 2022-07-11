if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'	" Git client for Vim
Plug 'tpope/vim-rhubarb'	" 
Plug 'overcache/NeoSolarized'	" NeoSolarized theme

if has("nvim")
  Plug 'neovim/nvim-lspconfig'
endif

call plug#end()

colorscheme NeoSolarized
