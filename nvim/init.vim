if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

" Plug 'tpope/vim-fugitive'	" Git client for Vim
" Plug 'tpope/vim-rhubarb'	" 

set backupskip=$TMPDIR/*,$TMP/*,$TEMP/*,/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

tnoremap <Esc> <C-\><C-n>
set noshowmatch

" Takuya's (devaslife) config
runtime ./plug.vim
runtime ./devaslife/init_takuya.vim

colorscheme NeoSolarized
