set backupskip=$TMPDIR/*,$TMP/*,$TEMP/*,/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,/private/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*

set noshowcmd
set noruler
set noshowmatch
set autochdir

runtime ./plug.vim " Plugins
runtime ./devaslife/init_takuya.vim " Takuya's (devaslife) config

tnoremap <Esc> <C-\><C-n> " Escape from terminal
nnoremap <C-`> :NvimTreeToggle<Return> " Open and close Nvim Tree
nnoremap <leader>ff <cmd>Telescope find_files<CR> " Fuzzy find files
nnoremap <leader>ft <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <silent> <leader>gg :LazyGit<cr> " Open lazygit
let g:vcoolor_map = '<C-c>'

colorscheme NeoSolarized

" Run Neoformat on save on all files
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
