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
